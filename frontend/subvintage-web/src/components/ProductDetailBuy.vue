<template>
    <div>
      <h1>Products</h1>
      <div v-if="loading">Loading...</div>
      <div v-else-if="error">{{ error.message }}</div>
      <div v-else>
        <div class="card" v-for="list in listings" :key="list.id">
          <div class="card-body">
            <h5 class="card-title">{{ list.title }}</h5>
            <p class="card-text">{{ list.description }}</p>
            <p class="card-text">Price: {{ list.price }} ETH</p>
            <p class="card-text">Owner: {{ list.owner }}</p>
            <button class="btn btn-primary" @click="buyProduct(list.id, list.price)">Buy</button>
          </div>
        </div>
      </div>
    </div>
  </template>
  
  <script>
  import Web3 from 'web3';
  import { fetchListingCreateds } from '@/graphql';
  import MarketplaceABI from '@/contracts/Marketplace.json'; // Ensure the path is correct
  
  export default {
    data() {
      return {
        listings: [],
        loading: true,
        error: null,
        web3: null,
        contract: null
      };
    },
    async created() {
      try {
        const data = await fetchListingCreateds();
        this.listings = data;
        console.log(data);
  
        // Initialize Web3
        if (window.ethereum) {
          this.web3 = new Web3(window.ethereum);
          await window.ethereum.enable();
        } else if (window.web3) {
          this.web3 = new Web3(window.web3.currentProvider);
        } else {
          throw new Error('Non-Ethereum browser detected. You should consider trying MetaMask!');
        }
  
        // Initialize contract
        const contractAddress = '0xa68ec9C82e98011aD043E4cece96AB49Ba345A82';
        this.contract = new this.web3.eth.Contract(MarketplaceABI, contractAddress);
      } catch (error) {
        this.error = error;
      } finally {
        this.loading = false;
      }
    },
    methods: {
      getImagePath(imageHash) {
        return `https://ipfs.io/ipfs/${imageHash}`;
      },
      async buyProduct(listingId, price) {
        try {
          const accounts = await this.web3.eth.getAccounts();
          await this.contract.methods.buyListing(listingId).send({
            from: accounts[0],
            value: price
          });
          alert('Product purchased successfully!');
        } catch (error) {
          console.error(error);
          alert('There was an error processing your transaction.');
        }
      }
    }
  };
  </script>
  
  <style scoped>
  .card {
    width: 18rem;
    margin: 1rem;
    display: inline-block;
    vertical-align: top;
  }
  
  .card-img-top {
    width: 100%;
    height: 200px;
    object-fit: cover;
  }
  
  .card-body {
    text-align: center;
  }
  </style>
  