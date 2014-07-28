var products;

products = [
  {
    id: "Product1", //Should be unique to identify the product selected
    name: "Product 1",
    imgUrl: "images/product_1.jpg",
    mortars: [
      {
        id: "Mortar1",
        name: "Mortar 1",
        left: 4,
        right: 4,
        top: 4,
        bottom: 4,
        fillImage: "images/mortar_fill1.jpg",
        imgUrl: "images/mortar_1.jpg"
      },
      {
        id: "Mortar2",
        name: "Mortar 2",
        left: 4,
        right: 4,
        top: 4,
        bottom: 4,
        fillImage: "images/mortar_fill2.jpg",
        imgUrl: "images/mortar_2.jpg"
      }
    ],
    brickTypes: [
      {
        id: "BrickSize1",
        name: "Brick Size 1",
        imgUrl: "images/brick_type_1.jpg",
        bricks: [
          {
            id: "Brick1",
            name: "Brick1",
            height: 40,
            width: 100,
            imgUrl: "images/brick_1_1.jpg",
            running: {
             imgUrl: "images/brick_r_1_1.jpg",
             width: 40,
             height: 100,
             id: "Brick1",
             name: "Brick1"
            },
            header: {
              id: "Brick1",
              name: "Brick1",
              height: 35,
              width: 105,
              imgUrl: "images/brick_1_1.jpg"
            }
          },
          {
            id: "Brick2",
            name: "Brick2",
            height: 35,
            width: 105,
            imgUrl: "images/brick_1_2.jpg",
            running: {
             imgUrl: "images/brick_r_1_2.jpg",
             width: 35,
             height: 105
            },
            header: {
              id: "Brick1",
              name: "Brick1",
              height: 35,
              width: 105,
              imgUrl: "images/brick_1_1.jpg"
            }
          }
        ]
      },
      {
        id: "BrickSize2",
        name: "Brick Size 2",
        imgUrl: "images/brick_type_2.jpg",
        bricks: [
          {
            id: "Brick1",
            name: "Brick21",
            imgUrl: "images/brick_2_1.jpg"
          },
          {
            id: "Brick2",
            name: "Brick2",
            imgUrl: "images/brick_2_2.jpg"
          }
        ]
      }
    ]
  },
  {
    id: "Product2", //Should be unique to identify the product selected
    name: "Product 2",
    imgUrl: "images/product_2.jpg",
    mortars: [
      {
        id: "Mortar3",
        name: "Mortar3",
        fillImage: "images/mortar_fill1.jpg",
        imgUrl: "images/mortar_1.jpg"
      },
      {
        id: "Mortar4",
        name: "Mortar4",
        fillImage: "images/mortar_fill2.jpg",
        imgUrl: "images/mortar_2.jpg"
      }
    ],
    brickTypes: [
      {
        id: "BrickSize1",
        name: "Brick Size 1",
        fillImage: "images/mortar_fill2.jpg",
        imgUrl: "images/brick_type_1.jpg",
        bricks: [
          {
            id: "Brick1",
            name: "Brick1",
            imgUrl: "images/brick_1_1.jpg"
          },
          {
            id: "Brick2",
            name: "Brick2",
            imgUrl: "images/brick_1_2.jpg"
          }
        ]
      },
      {
        id: "BrickSize2",
        name: "Brick Size 2",
        imgUrl: "images/brick_type_2.jpg",
        bricks: [
          {
            id: "Brick1",
            name: "Brick1",
            imgUrl: "images/brick_2_1.jpg"
          },
          {
            id: "Brick2",
            name: "Brick2",
            imgUrl: "images/brick_2_2.jpg"
          }
        ]
      }
    ]
  }
];