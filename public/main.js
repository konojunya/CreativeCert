const mintButton = document.querySelector("#btn-mint");
const contractAddress = "0x172be303274A300141D9Ebed7F356D5d18Adb223";
const abi = [
  {
    inputs: [
      {
        internalType: "address",
        name: "recipient",
        type: "address",
      },
    ],
    name: "mintTo",
    outputs: [
      {
        internalType: "uint256",
        name: "",
        type: "uint256",
      },
    ],
    stateMutability: "payable",
    type: "function",
  },
];

const web3 = new Web3(window.ethereum);
const contract = new web3.eth.Contract(abi, contractAddress);

mintButton.addEventListener("click", async () => {
  const accounts = await window.ethereum.request({
    method: "eth_requestAccounts",
  });
  const currentAccount = accounts[0];
  contract.methods
    .mintTo(currentAccount)
    .send(
      { from: currentAccount, value: Web3.utils.toWei("0.01", "ether") },
      function (err, res) {
        if (err) console.error(err);
        console.log(`The balance is: ${res}`);
      }
    );
});
