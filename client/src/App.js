import React, { useState, useEffect } from 'react';
import SimpleStorageContract from './contracts/SimpleStorage.json';
import Wallet from './contracts/Wallet.json';

import getWeb3 from './getWeb3';

import './App.css';

function App() {
  const [Web3, setWeb3] = useState(null);
  const [account, setAccount] = useState(null);
  const [balance, setBalance] = useState(0);
  const [contract, setContract] = useState(Wallet);

  useEffect(() => {
    (async () => {
      const web3 = await getWeb3();
      setWeb3(web3);

      const accounts = await web3.eth.getAccounts();
      setAccount(accounts[0]);

      let ethBalance = await web3.eth.getBalance(accounts[0]);
      ethBalance =
        Math.round(web3.utils.fromWei(ethBalance, 'ether') * 100) / 100;

      setBalance(ethBalance);
      // console.log(accounts);
    })();

    return () => {
      // cleanup;
    };
  }, []);

  const onClick = async () => {
    const networkId = await Web3.eth.net.getId();

    console.log('Network Id: ', networkId);

    const deployedNetwork = Wallet.networks[networkId];

    const WalletContract = new Web3.eth.Contract(
      Wallet.abi,
      deployedNetwork && deployedNetwork.address
    );

    await WalletContract.methods
      .withdraw(Web3.utils.toWei('0.005', 'ether'))
      .send({ from: account });

    const balance = await WalletContract.methods
      .getBalance()
      .call({ from: account });

    console.log('Wallet Balance: ', balance);
  };

  if (!Web3) {
    return <div>Loading Web3, accounts, and contract...</div>;
  }
  return (
    <div className="App">
      <h1>Good to Go!</h1>
      <p>Account: {account || ''}</p>
      <p>ETH Value: {balance}</p>

      <div onClick={onClick}>Click Here</div>
    </div>
  );
}

// class App extends Component {
//   state = { storageValue: 0, web3: null, accounts: null, contract: null };

//   componentDidMount = async () => {
//     try {
//       // Get network provider and web3 instance.
//       const web3 = await getWeb3();

//       // Use web3 to get the user's accounts.
//       const accounts = await web3.eth.getAccounts();

//       // Get the contract instance.
//       const networkId = await web3.eth.net.getId();
//       const deployedNetwork = SimpleStorageContract.networks[networkId];
//       const instance = new web3.eth.Contract(
//         SimpleStorageContract.abi,
//         deployedNetwork && deployedNetwork.address
//       );

//       // Set web3, accounts, and contract to the state, and then proceed with an
//       // example of interacting with the contract's methods.
//       this.setState({ web3, accounts, contract: instance }, this.runExample);
//     } catch (error) {
//       // Catch any errors for any of the above operations.
//       alert(
//         `Failed to load web3, accounts, or contract. Check console for details.`
//       );
//       console.error(error);
//     }
//   };

//   runExample = async () => {
//     const { accounts, contract } = this.state;

//     // Stores a given value, 5 by default.
//     await contract.methods.set(5).send({ from: accounts[0] });

//     // Get the value from the contract to prove it worked.
//     const response = await contract.methods.get().call();

//     // Update state with the result.
//     this.setState({ storageValue: response });
//   };

// render() {
//   if (!this.state.web3) {
//     return <div>Loading Web3, accounts, and contract...</div>;
//   }
//   return (
//     <div className="App">
//       <h1>Good to Go!</h1>
//       <p>Your Truffle Box is installed and ready.</p>
//       <h2>Smart Contract Example</h2>
//       <p>
//         If your contracts compiled and migrated successfully, below will show
//         a stored value of 5 (by default).
//       </p>
//       <p>
//         Try changing the value stored on <strong>line 42</strong> of App.js.
//       </p>
//       <div>The stored value is: {this.state.storageValue}</div>
//     </div>
//   );
// }
// }

export default App;
