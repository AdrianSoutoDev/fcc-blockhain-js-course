const ethers = require("ethers");
const fs = require("fs-extra");

async function main() {
  // const provider = new ethers.providers.JsonRpcProvider(
  //   "HTTP://192.168.56.1:7545"
  // );

  const provider = new ethers.JsonRpcProvider("HTTP://192.168.56.1:7545");

  const wallet = new ethers.Wallet(
    "0xa85a27b3e1a365e7f79ea0085ccd1641965cd49b8a2da5737ecf14018e97a9d0",
    provider
  );

  const abi = fs.readFileSync("./SimpleStorage_sol_SimpleStorage.abi", "utf-8");
  const binary = fs.readFileSync(
    "./SimpleStorage_sol_SimpleStorage.bin",
    "utf-8"
  );

  const contractFactory = new ethers.ContractFactory(abi, binary, wallet);
  console.log("Deploying, please wait...");

  // const contract = await contractFactory.deploy({ gasPrice; 100000000});
  // const contract = await contractFactory.deploy({ gasLimit; 100000000});
  const contract = await contractFactory.deploy();

  //deploymentTransaction.wait(1) =>  1 is the number of confirmations we have to wait to resolve the promise
  const deployReceipt = await contract.deploymentTransaction.wait(1);

  //here we go to deploy only with transasction data
  // const nonce = await wallet.getNonce();
  // const tx = {
  //   nonce: nonce,
  //   gasPrice: 20000000000, //becose is gas price expecified on ganache
  //   gasLimit: 1000000,
  //   to: null, // ecose is a contract
  //   value: 0, // becose we dont send any ether - data is the binary file content
  //   data: "0x608060405234801561001057600080fd5b50610889806100206000396000f3fe608060405234801561001057600080fd5b506004361061007d5760003560e01c80636057361d1161005b5780636057361d146100dc5780636f760f41146100f85780638bab8dd5146101145780639e7a13ad146101445761007d565b80632e64cec114610082578063471f7cdf146100a05780634f2be91f146100be575b600080fd5b61008a610175565b6040516100979190610638565b60405180910390f35b6100a861017e565b6040516100b59190610638565b60405180910390f35b6100c6610184565b6040516100d39190610638565b60405180910390f35b6100f660048036038101906100f19190610585565b61018d565b005b610112600480360381019061010d91906104dc565b610197565b005b61012e6004803603810190610129919061053c565b610274565b60405161013b9190610638565b60405180910390f35b61015e60048036038101906101599190610585565b6102a2565b60405161016c929190610653565b60405180910390f35b60008054905090565b60005481565b60006002905090565b8060008190555050565b6000604051806040016040528083815260200185858080601f016020809104026020016040519081016040528093929190818152602001838380828437600081840152601f19601f820116905080830192505050505050508152509050600181908060018154018082558091505060019003906000526020600020906002020160009091909190915060008201518160000155602082015181600101908051906020019061024692919061035e565b505050816002858560405161025c92919061061f565b90815260200160405180910390208190555050505050565b6002818051602081018201805184825260208301602085012081835280955050505050506000915090505481565b600181815481106102b257600080fd5b90600052602060002090600202016000915090508060000154908060010180546102db9061074c565b80601f01602080910402602001604051908101604052809291908181526020018280546103079061074c565b80156103545780601f1061032957610100808354040283529160200191610354565b820191906000526020600020905b81548152906001019060200180831161033757829003601f168201915b5050505050905082565b82805461036a9061074c565b90600052602060002090601f01602090048101928261038c57600085556103d3565b82601f106103a557805160ff19168380011785556103d3565b828001600101855582156103d3579182015b828111156103d25782518255916020019190600101906103b7565b5b5090506103e091906103e4565b5090565b5b808211156103fd5760008160009055506001016103e5565b5090565b600061041461040f846106a8565b610683565b9050828152602081018484840111156104305761042f61081c565b5b61043b84828561070a565b509392505050565b60008083601f84011261045957610458610812565b5b8235905067ffffffffffffffff8111156104765761047561080d565b5b60208301915083600182028301111561049257610491610817565b5b9250929050565b600082601f8301126104ae576104ad610812565b5b81356104be848260208601610401565b91505092915050565b6000813590506104d68161083c565b92915050565b6000806000604084860312156104f5576104f4610826565b5b600084013567ffffffffffffffff81111561051357610512610821565b5b61051f86828701610443565b93509350506020610532868287016104c7565b9150509250925092565b60006020828403121561055257610551610826565b5b600082013567ffffffffffffffff8111156105705761056f610821565b5b61057c84828501610499565b91505092915050565b60006020828403121561059b5761059a610826565b5b60006105a9848285016104c7565b91505092915050565b60006105be83856106f5565b93506105cb83858461070a565b82840190509392505050565b60006105e2826106d9565b6105ec81856106e4565b93506105fc818560208601610719565b6106058161082b565b840191505092915050565b61061981610700565b82525050565b600061062c8284866105b2565b91508190509392505050565b600060208201905061064d6000830184610610565b92915050565b60006040820190506106686000830185610610565b818103602083015261067a81846105d7565b90509392505050565b600061068d61069e565b9050610699828261077e565b919050565b6000604051905090565b600067ffffffffffffffff8211156106c3576106c26107de565b5b6106cc8261082b565b9050602081019050919050565b600081519050919050565b600082825260208201905092915050565b600081905092915050565b6000819050919050565b82818337600083830152505050565b60005b8381101561073757808201518184015260208101905061071c565b83811115610746576000848401525b50505050565b6000600282049050600182168061076457607f821691505b60208210811415610778576107776107af565b5b50919050565b6107878261082b565b810181811067ffffffffffffffff821117156107a6576107a56107de565b5b80604052505050565b7f4e487b7100000000000000000000000000000000000000000000000000000000600052602260045260246000fd5b7f4e487b7100000000000000000000000000000000000000000000000000000000600052604160045260246000fd5b600080fd5b600080fd5b600080fd5b600080fd5b600080fd5b600080fd5b6000601f19601f8301169050919050565b61084581610700565b811461085057600080fd5b5056fea2646970667358221220279ffbbf659ab9cf00701cbf59717b93b21743bc89221c8f355d01507d6d1e2b64736f6c63430008070033",
  //   chainId: 1337, // id for ganache
  // };

  //this opnly sign the transaction but don't send it
  //const signedTxResponse = await wallet.signTransaction(tx);

  // const sentTxResponse = await wallet.sendTransaction(tx);
  // await sentTxResponse.wait(1);
  // console.log(sentTxResponse);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
