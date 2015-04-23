class Order < ActiveRecord::Base
  belongs_to :user
  has_many :order_items, :dependent => :destroy
  has_many :order_status_transitions, :dependent => :destroy
  validates_presence_of :user

  state_machine :status, :initial => :new do
    audit_trail :context => :response_message

    event :transact do
      transition [:transaction_error, :new] => :transacted
    end

    event :fail_transaction do
      transition [:transaction_error, :new] => :transaction_error
    end

    event :fail_api_call do
      transition [:transacted, :api_error] => :api_error
    end

    event :make_api_call do
      transition [:transacted, :api_error] => :api_success
    end
  end

  # utility methods

  def total_price
    order_items.inject(0) {|sum, item| sum + item.total_price}
  end

  def post_api_order
    ps = PrintIOService.new(self)
    ps.post_order
  end

  # state_machine override methods

  def response_message(transition)
    if transition.args.present?
      transition.args.last.to_s
    else
      'no response'
    end
  end

end
