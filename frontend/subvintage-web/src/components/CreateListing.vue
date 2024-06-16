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
      <h2>Create New Listing</h2>
      <form @submit.prevent="submitNewListing">
        <div class="form-group">
          <label for="title">Title:</label>
          <input type="text" id="title" v-model="newListing.title" required class="form-control"/>
        </div>
        <div class="form-group">
          <label for="description">Description:</label>
          <textarea id="description" v-model="newListing.description" required class="form-control"></textarea>
        </div>
        <div class="form-group">
          <label for="price">Price (USD):</label>
          <input type="number" id="price" v-model="newListing.price" required class="form-control"/>
        </div>
        <div class="form-group">
          <label for="ipfsLink">IPFS Link:</label>
          <input type="text" id="ipfsLink" v-model="newListing.ipfsLink" required class="form-control"/>
        </div>
        <button type="submit" class="btn btn-success">Create Listing</button>
      </form>
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
        newListing: {
          title: '',
          description: '',
          price: 0,
          ipfsLink: ''
        },
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
        const contractAddress = '0xFaE26507C28b99E466f27e34DE5c6413114f2c2b';
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
            value: this.web3.utils.toWei(price.toString(), 'ether')
          });
          alert('Product purchased successfully!');
        } catch (error) {
          console.error(error);
          alert('There was an error processing your transaction.');
        }
      },
      async submitNewListing() {
        try {
          const accounts = await this.web3.eth.getAccounts();
          const { title, description, price } = this.newListing;
          await this.contract.methods.createListing(
            title,
            description,
            price
          ).send({ from: accounts[0] });
          alert('Listing created successfully!');
          this.resetForm();
        } catch (error) {
          console.error(error);
          alert('There was an error creating the listing.');
        }
      },
      resetForm() {
        this.newListing = {
          title: '',
          description: '',
          price: 0,
          ipfsLink: ''
        };
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
  
  .form-group {
    margin-bottom: 1rem;
  }
  
  .form-control {
    width: 100%;
    padding: 0.5rem;
    margin-bottom: 0.5rem;
  }
  
  .btn-success {
    margin-top: 1rem;
  }
  </style>
  