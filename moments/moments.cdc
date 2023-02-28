import FungibleToken from "./FungibleToken.cdc"
import NonFungibleToken from "./NonFungibleToken.cdc"
import FlowToken from "./FlowToken.cdc"

pub contract Moments: NonFungibleToken {

    // The name of the NFT
    pub let name: String

    // The symbol of the NFT
    pub let symbol: String

    // The total supply of the NFT
    pub var totalSupply: UInt64

    // An array of all NFTs in existence
    pub var allMoments: [Moment]

    // A struct defining the Moments NFT
    pub struct Moment: NonFungibleToken.Item {
        pub let id: UInt64
        pub let metadata: {String: String}
        pub var owner: Address

        init(id: UInt64, metadata: {String: String}, owner: Address) {
            self.id = id
            self.metadata = metadata
            self.owner = owner
        }
    }

    init(name: String, symbol: String) {
        self.name = name
        self.symbol = symbol
        self.totalSupply = 0
        self.allMoments = []
    }

    // Mint a new Moment NFT
    pub fun mint(metadata: {String: String}) {
        let moment = Moment(
            id: self.totalSupply + 1,
            metadata: metadata,
            owner: self.account.address
        )
        self.totalSupply += 1
        self.allMoments.append(moment)
        self.mintNonFungibleToken(recipient: self.account.address, id: moment.id)
    }

    // Get the metadata for a specific Moment NFT
    pub fun getMomentMetadata(id: UInt64): {String: String} {
        let moment = self.getNonFungibleToken(id: id) as! Moment
        return moment.metadata
    }
}
