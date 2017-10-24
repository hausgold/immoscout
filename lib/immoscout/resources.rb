# errors
require_relative 'errors/not_found'

# api client
require_relative 'api/client'

# root hashie resource
require_relative 'resources/base'

# subresources
require_relative 'resources/address'
require_relative 'resources/contact'
require_relative 'resources/price'
require_relative 'resources/courtage'
require_relative 'resources/api_search_data'

# renderable resources
require_relative 'resources/residential'
require_relative 'resources/house'
require_relative 'resources/apartment'
