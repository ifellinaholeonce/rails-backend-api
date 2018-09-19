# E-Commerce Backend API

### Available at http://35.221.43.201/api/v1/shops/:id

*available shops are 1 and 2*
*try **http://35.221.43.201/api/v1/shops/1** to begin*

This was deployed using Docker and GKE.

TO build locally
```
bin/rails db:create
bin/rails db:migrate
bin/rails db:seed
bin/rails s
Browser to localhost:3000
```

All data is sent and received as JSON. Built with RoR and FastJsonApi gem.
For demonstration purposes, the DELETE action is only enabled on line items.

## Shops

```
GET /shops/:id
```

The id of the shop must be given in the request. The response will indicate the shop name and high level order data, as well as relations:

For example: *GET /shops/1* would result in:
```JSON
{
  "data":
    {
      "id":"1",
      "type":"shop",
      "attributes":
        {
          "name":"My Shop",
          "total_orders":1,
          "unfulfilled_orders_count":0,
          "unfinished_orders_count":1,
          "fulfilled_orders_count":0
        },
      "relationships":
        {
          "products":
            {
              "data":
                [
                  {
                    "id":"1",
                    "type":"product"
                  },
                  {
                    "id":"2",
                    "type":"product"
                  }
                ]
            },
            "orders":
              {"data":
                [
                  {
                    "id":"1",
                    "type":"order"
                  }
                ]
              }
        }
    }
}
```

## Products

```
GET /shops/:id/products/
```

The id of the shop must be given in the request. The response will list all products for that shop with relevant data such as price and inventory count (currently limited to 10, future iterations will bring pagination). It will also include relationships to the shop and to any orders it belongs to as a line_item.

For example: *GET /shops/1/products*
#### Response
```JSON
{
  "data":
  [
    {
      "id":"1",
      "type":"product",
      "attributes":
      {
        "shop_id":1,
        "name":"My Product 0",
        "description":"My Product Description",
        "count":10,
        "price":5
      },
      "relationships":
      {
        "shop":
        {
          "data":
          {
            "id":"1",
            "type":"shop"
          }
        },
        "line_items":
        {
          "data":
          [
            {
              "id":"1",
              "type":"line_item"
            }
          ]
        },
        "orders":
        {
          "data":
          [
            {
              "id":"1",
              "type":"order"
            }
          ]
        }
      }
    },
    {
      "id":"2",
      ...
  ]
}
```
### An Individual product can be inspected with a get request
```
GET /shops/:id/products/:id
```
#### Response
```JSON
{
  "data":
  {
    "id":"1",
    "type":"product",
    "attributes":
    {
      "shop_id":1,
      "name":"My Product 0",
      "description":"My Product Description",
      "count":10,
      "price":5
    },
    "relationships":
    {
      "shop":
      {
        "data":
        {
          "id":"1",
          "type":"shop"
        }
      },
      "line_items":
      {
        "data":
        [
          {
            "id":"1",
            "type":"line_item"
          }
        ]
      },
      "orders":
      {
        "data":
        [
          {
            "id":"1",
            "type":"order"
          }
        ]
      }
    }
  }
}
```
### Products can be created by post request

```
POST /shops/:id/products
```

#### Input
Name | Type | Description
---|---|---|
Name | String | Name of the product *(Optional)*
Description | String | Description of the product *(Optional)*
Price | Integer | Price **Mandatory**
Count | Integer | Inventory count for product *(Optional)*

For example *POST /shops/1/products*:
```JSON
{
  "name": "Lando's IPA",
  "description": "A N.E. style IPA in 500ml cans",
  "price": 3,
  "count": 24
}
```

#### Response
```JSON
{
  "data":
  {
    "id":"3",
    "type":"product",
    "attributes":
    {
      "shop_id":1,
      "name":"Lando's IPA",
      "description":"A N.E. style IPA in 500ml cans",
      "count":0,
      "price":3
    },
    "relationships":
    {
      "shop":
      {
        "data":
        {
          "id":"1",
          "type":"shop"
        }
      },
      "line_items":{"data":[]},"orders":{"data":[]}
    }
  }
}
```
### Products can be updated by put/patch request

```
PATCH /shops/:id/products/:id
```

#### Input
Name | Type | Description
---|---|---|
Name | String | Name of the product *(Optional)*
Description | String | Description of the product *(Optional)*
Price | Integer | Price **Defaults to 0**
Count | Integer | Inventory count for product *(Optional)*

For example *PATCH /shops/1/products/1*:
```JSON
{
  "name": "Lando's IPA",
  "description": "A West Coast style IPA in 750ml bottles",
  "price": 5,
  "count": 24
}
```
*Note: Any updates to a product maintains the associations with orders*

#### Response
```JSON
{
  "data":
  {
    "id":"2",
    "type":"product",
    "attributes":
    {
      "shop_id":1,
      "name":"Landos IPA",
      "description":"A West Coast style IPA in 750ml bottles",
      "count":10,
      "price":5
    },
    "relationships":
    {
      "shop":
      {
        "data":
        {
          "id":"1",
          "type":"shop"
        }
      },
      "line_items":
      {
        "data":
        [
          {
            "id":"2",
            "type":"line_item"
          }
        ]
      },
      "orders":
      {
        "data":
        [
          {
            "id":"1",
            "type":"order"
          }
        ]
      }
    }
  }
}
```

## Orders

```
GET /shops/:id/orders/
```

The id of the shop must be given in the request. The response will list all order for that shop with relevant data such as total price, number of items and status (unfinished, unfulfilled, fulfilled) (currently limited to 10, future iterations will bring pagination). It will also include relationships to the shop and to any products it has as a line_item.

For example: *GET /shops/1/orders*
#### Response
```JSON
{
  "data":
  [
    {
      "id":"1",
      "type":"order",
      "attributes":
      {
        "status":"unfinished",
        "total_sum":10,
        "item_count":2
      },
      "relationships":
      {
        "shop":
        {
          "data":
          {
            "id":"1",
            "type":"shop"
          }
        },
        "line_items":
        {
          "data":
          [
            {
              "id":"1",
              "type":"line_item"
            },
            {
              "id":"2",
              "type":"line_item"
            }
          ]
        }
      }
    }
  ]
}
```
### An Individual Order can be inspected by a get request
```
GET /shops/:id/orders/:id
```
#### Response
```JSON
{
  "data":
  {
    "id":"1",
    "type":"order",
    "attributes":
    {
      "status":"unfinished",
      "total_sum":10,
      "item_count":2
    },
    "relationships":
    {
      "shop":
      {
        "data":
        {
          "id":"1",
          "type":"shop"
        }
      },
      "line_items":
      {
        "data":
        [
          {
            "id":"1",
            "type":"line_item"
          },
          {
            "id":"2",
            "type":"line_item"
          }
        ]
      }
    }
  }
}
```
### Orders can be created by post request

```
POST /shops/:id/orders
```

#### Input
Name | Type | Description
---|---|---|
status | String | One of: unfinished, unfulfilled, fulfilled
product_ids | Array | An array of product ids belonging to the specified shop

For example *POST /shops/1/orders*:
```JSON
{
  "status": "unfulfilled",
  "product_ids": [1,2]
}
```

#### Response
```JSON
{
  "data":
  {
    "id":"3",
    "type":"order",
    "attributes":
    {
      "status":"unfulfilled",
      "total_sum":10,
      "item_count":2
    },
    "relationships":
    {
      "shop":
      {
        "data":
        {
          "id":"1",
          "type":"shop"
        }
      },
      "line_items":
      {
        "data":
        [
          {
            "id":"3",
            "type":"line_item"
          },
          {
            "id":"4",
            "type":"line_item"
          }
        ]
      }
    }
  }
}
```
### Orders can be updated by put/patch request

```
PATCH /shops/:id/orders/:id
```

#### Input
Name | Type | Description
---|---|---|
status | String | One of: unfinished, unfulfilled, fulfilled
product_ids | Array | An array of product ids belonging to the specified shop

*Note: An update does **not** need to contain both input values*

For example *PATCH /shops/1/orders/3*:
```JSON
{
  "status": "unfinished",
  "product_ids": [1]
}
```

#### Response
```JSON
{
  "data":
  {
    "id":"3",
    "type":"order",
    "attributes":
    {
      "status":"unfulfilled",
      "total_sum":5,
      "item_count":1
    },
    "relationships":
    {
      "shop":
      {
        "data":
        {
          "id":"1",
          "type":"shop"
        }
      },
      "line_items":
      {
        "data":
        [
          {
            "id":"3",
            "type":"line_item"
          }
        ]
      }
    }
  }
}
```

## Line Items

Can found through products
```
GET /shops/:id/products/:id/line_items/
```
Or through orders
```
GET /shops/:id/orders/:id/line_items/
```
Either of these end points will give a response that lists all line items for the relevant product or order.

#### Response
```JSON
{
  "data":
  [
    {
      "id":"1",
      "type":"line_item",
      "attributes":
      {
        "id":1,
        "shop_id":1,
        "order_id":1,
        "product_id":1,
        "price":5
      },
      "relationships":
      {
        "order":
        {
          "data":
          {
            "id":"1",
            "type":"order"
          }
        },
        "product":
        {
          "data":
          {
            "id":"1",
            "type":"product"
          }
        }
      }
    },
    {
      "id":"2",
      ...
    }
  ]
}
```
#### An individual line item can be inspected by get request
```
GET /shops/:id/products/:id/line_items/:id

GET /shops/:id/orders/:id/line_items/:id
```
#### Response
```JSON
{
  "data":
  {
    "id":"1",
    "type":"line_item",
    "attributes":
    {
      "id":1,
      "shop_id":1,
      "order_id":1,
      "product_id":1,
      "price":5
    },
    "relationships":
    {
      "order":
      {
        "data":
        {
          "id":"1",
          "type":"order"
        }
      },
      "product":
      {
        "data":
        {
          "id":"1",
          "type":"product"
        }
      }
    }
  }
}
```

#### An individual line item can be destroyed by a DELETE request
```
DELETE /shops/:id/products/:id/line_items/:id

DELETE /shops/:id/products/:id/line_items/:id
```
*Note: the response to this request will return the update list of list items for the product/order*

#### Response
```JSON
{
  "data":
  [
    {
      "id":"1",
      "type":"line_item",
      "attributes":
      {
        "id":1,
        "shop_id":1,
        "order_id":1,
        "product_id":1,
        "price":5
      },
      "relationships":
      {
        "order":
        {
          "data":
          {
            "id":"1",
            "type":"order"
          }
        },
        "product":
        {
          "data":
          {
            "id":"1",
            "type":"product"
          }
        }
      }
    },
    {
      "id":"2",
      ...
    }
  ]
}
```