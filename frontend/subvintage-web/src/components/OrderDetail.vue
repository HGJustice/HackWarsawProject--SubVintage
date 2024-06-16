<template>
    <div class="container mt-4">
      <div class="row">
        <div class="col-md-8">
          <div class="card mb-4">
            <div class="card-body">
              <h2>{{ product.name }}</h2>
              <p><strong>Price:</strong> {{ product.price }} $</p>
              <p><strong>Seller:</strong> selleradresssxxxxxxxxxID</p>
              <p><strong>Buyer:</strong> buyeradresssxxxxxxxxxID</p>

              <p>{{ product.description }}</p>
              <div class="d-flex align-items-center mt-4">
                <button @click="likeProduct" class="btn btn-outline-primary">
                  <i class="fas fa-heart"></i> {{ likes }} Likes
                </button>
              </div>
            </div>
          </div>
        </div>
        <div class="col-md-4">
          <div class="card mb-4">
            <div class="card-body">
              <h4>Order Timeline</h4>
              <ul class="timeline">
                <li v-for="(step, index) in orderSteps" :key="index" :class="{ 'timeline-inverted': index % 2 !== 0 }">
                  <div class="timeline-badge bg-primary"><i class="fas fa-check"></i></div>
                  <div class="timeline-panel">
                    <div class="timeline-heading">
                      <h5 class="timeline-title">{{ step.title }}</h5>
                    </div>
                    <div class="timeline-body">
                      <p>{{ step.description }}</p>
                      <button v-if="step.hasData" @click="addData(step)" class="btn btn-success btn-sm">
                        Add Data
                      </button>
                    </div>
                  </div>
                  <hr class="my-4">
                </li>
              </ul>
            </div>
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
          name: 'Tommy Hilfiger Hoodie',
          description: 'Tommy Hilfiger Hoodie.',
          price: 90
        },
        likes: 0,
        orderSteps: [
          {
            title: 'Order Creation',
            description: 'The order has been created.',
            hasData: false // Define si se puede agregar datos en esta etapa
          },
          {
            title: 'Payment Confirmation',
            description: 'The payment has been confirmed.',
            hasData: false
          },
          {
            title: 'Shipping Information Update',
            description: 'The shipping information has been updated.',
            hasData: true // Ejemplo de etapa donde se puede agregar datos
          },
          {
            title: 'Buyer`s Shipping Verification',
            description: 'The buyer has verified the shipment.',
            hasData: false
          },
          {
            title: 'Product Reception',
            description: 'The product has been received by the buyer.',
            hasData: true
          },
          {
            title: 'Funds Release',
            description: 'Funds have been released to the seller.',
            hasData: false
          },
          {
            title: 'Rating and Review System (Buyer)',
            description: 'The buyer has rated and reviewed the product.',
            hasData: true
          },
          {
            title: 'Rating and Review System (Seller)',
            description: 'Rating and Review System (Seller)',
            hasData: false
          },
          {
            title: 'Claims',
            description: 'Claims in progress, if necessary.',
            hasData: false
          },
        ],
      };
    },
    methods: {
      likeProduct() {
        this.likes++;
      },
      addData(step) {
        // Aquí puedes implementar la lógica para agregar datos específicos para la etapa seleccionada
        alert(`Agregando datos para: ${step.title}`);
      },
    },
  };
  </script>
  
  <style>
  /* Estilos para el timeline en dispositivos móviles */
  @media (max-width: 768px) {
    .timeline li {
      margin-bottom: 30px;
    }
  
    .timeline li .timeline-panel {
      padding: 15px;
    }
  
    .timeline li hr {
      border-color: #ccc;
    }
  }
  </style>
  