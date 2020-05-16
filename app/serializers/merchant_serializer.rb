class MerchantSerializer < ActiveModel::Serializer
  include FastJsonapi::ObjectSerializer
  attributes :name
end

#
# "data": [
#   {
#     "id": "1",
#       "type": "merchant",
#       "attributes": {
#         "name": "Mike's Awesome Store",
#       }
#   },
