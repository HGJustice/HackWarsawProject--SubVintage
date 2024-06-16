import Vue from 'vue'
import App from './App.vue'
import Web3 from 'web3';
import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap'
import VueRouter from 'vue-router'
import ProductList from './components/ProductList.vue'
import ProductDetail from './components/ProductDetailBuy.vue'
import OrderDetail from './components/OrderDetail.vue'
import UserCreatedList from './components/UserCreatedList.vue';
import ListingBoughtList from './components/ListingBoughtList.vue';
import ListingCreatedList from './components/ListingCreatedList.vue';
import CreateUser from './components/CreateUser.vue'
import MarketPlace from './components/MarketPlace.vue'
import HelloWorld from './components/HelloWorld.vue'
import CreateListing from './components/CreateListing.vue'

Vue.config.productionTip = false

Vue.use(VueRouter)


// Configurar el proveedor de Web3 (ejemplo: MetaMask)
let web3;

if (window.ethereum) {
  web3 = new Web3(window.ethereum);
  try {
    // Solicitar acceso a MetaMask
    window.ethereum.enable();
  } catch (error) {
    console.error('User denied account access or MetaMask not installed');
  }
} else if (window.web3) {
  web3 = new Web3(window.web3.currentProvider);
} else {
  console.log('Non-Ethereum browser detected. You should consider trying MetaMask!');
}

Vue.prototype.$web3 = web3;

const routes = [
  { path: '/', component: ProductList },
  { path: '/product', component: ProductList },
  { path: '/product/:id', component: ProductDetail, props: true },
  { path: '/OrderDetail', component: OrderDetail, props: true },
  { path: '/UserCreatedList', component: UserCreatedList, props: true },
  { path: '/ListingCreatedList', component: ListingCreatedList, props: true },
  { path: '/ListingBoughtList', component: ListingBoughtList, props: true },
  { path: '/CreateUser', component: CreateUser, props: true },
  { path: '/MarketPlace', component: MarketPlace, props: true },
  { path: '/HelloWorld', component: HelloWorld, props: true },
  { path: '/CreateListing', component: CreateListing, props: true },

]

const router = new VueRouter({
  routes,
  mode: 'history' // Modo de historial para rutas limpias
})

new Vue({
  router,
  render: h => h(App),
}).$mount('#app')