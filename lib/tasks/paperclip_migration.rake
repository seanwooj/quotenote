namespace :paperclip_migration do
  desc "migrate files from filesystem to s3"
   task :migrate_to_s3 => :environment do
     klasses = [:backgrounds] # Replace with your real model names.

     klasses.each do |klass_key|
       klass = klass_key.to_s.classify.constantize rescue nil

       if klass.blank?
         puts "#{klass_key.to_s.classify} is not defined in this app."
         next
       end

       definitions = klass.respond_to?(:attachment_definitions) ? klass.attachment_definitions : nil

       if definitions.blank?
         puts "There are no paperclip attachments defined for the class #{klass.to_s}"
         next
       end

       definitions.keys.each do |attachment|
         records = klass.where("#{attachment}_file_name is not NULL")

         records.each do |record|
           path = record.send(attachment).path(:original)
           full_path = File.join( Rails.root, 'public', 'system', path )

           unless File.exists?( full_path )
             puts "Can't find file: #{full_path} NOT MIGRATING..."
             next
           end

           file_data = File.open( full_path )
           puts "Saving file: #{full_path} to Amazon S3..."
           record.send("#{attachment}=", file_data)
           record.save!
           file_data.close
         end
       end
     end
   end
end
