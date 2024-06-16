<template>
    <div class="container">
      <div class="row">
        <div class="col-md-6">
          <img :src="product.image" class="img-fluid" alt="Producto">
        </div>
        <div class="col-md-6">
          <h2>{{ product.name }}</h2>
          <p><strong>Precio:</strong> {{ product.price }} $</p>
          <p>{{ product.description }}</p>
          <div class="d-flex align-items-center mt-4">
            <button @click="likeProduct" class="btn btn-outline-primary">
              <i class="fas fa-heart"></i> {{ likes }} Likes
            </button>
            <router-link  :to="'/order/' + product.id" class=" routerLink btn btn-success ml-2">Comprar</router-link>

          </div>
        </div>
      </div>
    </div>
  </template>
  
  <script>
  export default {
    props: ['id'],
    data() {
      return {
        product: {
          id: 1,
          name: 'Producto de ejemplo',
          description: 'Descripción del producto de ejemplo.',
          price: 50,
          image: 'https://via.placeholder.com/400x300', // URL de la imagen del producto
          likes: 0
        }
      };
    },
    computed: {
      likes() {
        return this.product.likes;
      }
    },
    methods: {
      likeProduct() {
        this.product.likes++;
      },
      buyProduct() {
        // Aquí podrías implementar la lógica para agregar el producto al carrito o proceder con el proceso de compra
        alert(`¡Producto "${this.product.name}" comprado!`);
      }
    }
  };
  </script>
  
  <style>
  /* Estilos adicionales según necesidades */
  .routerLink{
     text-decoration: none;
 }
  </style>
  