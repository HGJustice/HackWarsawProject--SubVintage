// src/graphql.js
import { request, gql } from 'graphql-request';

//const endpoint = 'https://api.studio.thegraph.com/query/71573/subvintage/version/latest';

const endpoint = 'https://api.studio.thegraph.com/query/71573/subvinted3/0.01';
const userCreatedQuery = gql`
  {
    userCreateds(first: 5) {
      id
      UserManagement_id
      username
      blockNumber
      blockTimestamp
      transactionHash
    }
  }
`;

const listingBoughtQuery = gql`
  {
    listingBoughts(first: 5) {
      id
      Marketplace_id
      buyer
      escrowContract
      blockNumber
      blockTimestamp
      transactionHash
    }
  }
`;

const listingCreatedQuery = gql`
  {
    listingCreateds(first: 5) {
      id
      Marketplace_id
      owner
      description
      price
      blockNumber
      blockTimestamp
      transactionHash
    }
  }
`;

export const fetchUserCreateds = async () => {
  try {
    const data = await request(endpoint, userCreatedQuery);
    return data.userCreateds;
  } catch (error) {
    console.error('Error fetching userCreateds:', error);
    throw error;
  }
};

export const fetchListingBoughts = async () => {
  try {
    const data = await request(endpoint, listingBoughtQuery);
    return data.listingBoughts;
  } catch (error) {
    console.error('Error fetching listingBoughts:', error);
    throw error;
  }
};

export const fetchListingCreateds = async () => {
  try {
    const data = await request(endpoint, listingCreatedQuery);
    return data.listingCreateds;
  } catch (error) {
    console.error('Error fetching listingCreateds:', error);
    throw error;
  }
};
