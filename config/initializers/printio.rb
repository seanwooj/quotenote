PRINT_IO_CONFIG = YAML.load_file("#{Rails.root}/config/printio.yml")[Rails.env]

PRINT_IO_RECIPE = PRINT_IO_CONFIG['recipe_id']
PRINT_IO_API = PRINT_IO_CONFIG['api_key']
