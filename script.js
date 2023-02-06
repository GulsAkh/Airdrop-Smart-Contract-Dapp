const contractAddress = "0xBf8b1acBB0040CA21d66b24dB2297768079C86E3";
const contractABI = [{"inputs":[{"internalType":"string","name":"_note","type":"string"}],"name":"writeNote","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"getNote","outputs":[{"internalType":"string","name":"","type":"string"}],"stateMutability":"view","type":"function"}]
let signer
let contract

const provider = new ethers.providers.Web3Provider(window.ethereum, 80001) //Matic chain-ID
//подключает к провайдеру который есть в браузере в данном случае Метамаск
provider.send("eth_requestAccounts", []).then(() => {
    provider.listAccounts().then( (accounts) => {
        signer = provider.getSigner(accounts[0]);
        contract = new ethers.Contract( //это путь к оригинальному контракту, напрямую взаимод с контактом в блокчейне
            contractAddress,
            contractABI,
            signer
        )
    }
    )
}
)
//запрашивает все аккаунты (публичные ключи) в метамаске, 
//затем создает список аккаунтов, 
//затем принимает аргумент аккаунт
//signer достается из providera
//c помощью signer можно вызвать функцию getAddress
//userу показать его аккаунт можно с помощью signer

async function getNote(){
    console.log(await contract.getNote());
}

async function writeNote(){
    const note = document.getElementById("inputNote").value;
    //console.log(note);
    await contract.writeNote(note);
}