<template>
    <div class="container">
        <h1>SubVintage Marketplace</h1>

        <div class="input-group mb-3">
            <input type="text" class="form-control" placeholder="Search items..." v-model="searchTerm">
            <div class="input-group-append">
                <button class="btn btn-outline-secondary" type="button" @click="clearSearch">Clean</button>
            </div>
        </div>
        <div class="row">

            <div class="row">
                <div class="col-md-4 mb-4" v-for="product in products" :key="product.id">
                    <router-link :to="'/product/' + product.id" class=" routerLink card-link">
                        <div class="card">
                            <img :src="getImagePath(product.image)" class="card-img-top fixed-size" alt="Producto">
                            <div class="card-body">
                                <h5 class="card-title">{{ product.name }}</h5>
                                <p class="card-text">{{ product.description }}</p>
                                <p class="card-text"><strong>Precio:</strong> {{ product.price }} $</p>
                            </div>
                            <div class="d-flex justify-content-between align-items-center">
                                <button class="btn btn-outline-primary" @click="likeProduct(product.id)">
                                    <i class="fa fa-heart"></i> Like <span class="badge badge-primary">{{ product.likes
                                    }}</span>
                                </button>
                                <button class="btn btn-success" @click="buyProduct(product.id)">
                                    <i class="fa fa-shopping-cart"></i> Buy
                                </button>
                            </div>
                        </div>
                    </router-link>
                </div>
            </div>

        </div>

        <div v-if="filteredProducts.length === 0 && searchTerm.length > 0">
            <p>No se encontraron productos que coincidan con "{{ searchTerm }}".</p>
        </div>
        <div v-else-if="filteredProducts.length === 0">
            <p>No se encontraron productos.</p>
        </div>
    </div>
</template>
  
<script>

export default {
    data() {
        return {
            searchTerm: '',
            products: [
   
    {
      "id": 3,
      "name": "Gucci GG Marmont Mini Bag",
      "description": "Luxurious mini bag with a chevron pattern and GG logo.",
      "price": 980,
      "image": "gucci_gg_marmont_mini_bag.jpeg",
      "likes": 0
    },
    {
      "id": 4,
      "name": "Tommy Hilfiger Hoodie",
      "description": "Comfortable and stylish hoodie with Tommy Hilfiger branding.",
      "price": 90,
      "image": "tommy_hilfiger_hoodie.jpeg",
      "likes": 0
    },
    {
      "id": 1,
      "name": "Nike Air Max 270",
      "description": "High-performance lifestyle shoes with 270 degrees of visibility in the air unit.",
      "price": 160,
      "image": "nike_air_max_270.jpeg",
      "likes": 0
    },
    {
      "id": 2,
      "name": "Adidas Ultraboost 21",
      "description": "Premium running shoes with responsive Boost cushioning.",
      "price": 180,
      "image": "adidas_ultraboost_21.jpeg",
      "likes": 0
    }
  ]
        };
    },
    computed: {
        filteredProducts() {
            if (!this.searchTerm) {
                return this.products;
            }
            const lowerCaseTerm = this.searchTerm.toLowerCase();
            return this.products.filter(product =>
                product.name.toLowerCase().includes(lowerCaseTerm) ||
                product.description.toLowerCase().includes(lowerCaseTerm)
            );
        }
    },
    methods: {
        likeProduct(productId) {
            const product = this.products.find(p => p.id === productId);
            if (product) {
                product.likes++;
            }
        },
        buyProduct(productId) {
            alert(`Producto ${productId} comprado!`);
            // Aquí puedes implementar la lógica para la compra del producto
        },
        clearSearch() {
            this.searchTerm = '';
        },
        getImagePath(image) {
            return require(`@/assets/images/${image}`);
        }

    }
};
</script>
  
<style>
.fixed-size {
  width: 200px;
  height: 200px;
  object-fit: cover; /* Optional: ensures the image covers the container */
}
</style>
  