const {assert} = require('chai')
// const { Item } = require('react-bootstrap/lib/Breadcrumb')
// const _deploy_contracts = require('../migrations/2_deploy_contracts')

const KryptoBird = artifacts.require('./KryptoBird')


// check for chai 
require('chai')
.use(require('chai-as-promised'))
.should()

contract('KryptoBird', (accounts)=> {
    let contract 
    // before tells our test to run this forst before anything else
    before( async ()=> {
        contract = await KryptoBird.deployed() 
        }
    )
    // testing ontainer - describe

    describe('deployment', async ()=> {
        // test samples with writing it
        it('deploys successfuly', async() => {
            const address = await contract.address;
            assert.notEqual(address, '')
            assert.notEqual(address, null)
            assert.notEqual(address, undefined)
            assert.notEqual(address, 0x0)
        })
        it('has a name', async() => {
            const name = await contract.name()
            assert.equal(name, 'KryptoBird')
        })
        it('has a symbol', async() => {
            const symbol = await contract.symbol()
            assert.equal(symbol, 'KBIRDZ')
        })
    })


    describe('minting', async ()=> {
        it('create a new token', async() => {
            const result = await contract.mint('https...1')
            const totalSupply = await contract.totalSupply()
            //Success
            assert.equal(totalSupply, 1)
            const event = result.logs[0].args
            assert.equal(event._from, '0x0000000000000000000000000000000000000000','from the contract')
            assert.equal(event._to, accounts[0],'to is msg.sender')
            
            //Failire
            await contract.mint('https...1').should.be.rejected;
        })
    })

    describe('indexing', async ()=> {
        it('lists KeyptoBird', async() => {
            await contract.mint('https...2')
            await contract.mint('https...3')
            await contract.mint('https...4')
            const totalSupply = await contract.totalSupply()
        
            // lopp through list and grap KBirdz from list
            let result = []
            let KryptoBird
            for (let i = 0; i < totalSupply; i++) {
                KryptoBird = await contract.kryptoBird(i)
                result.push(KryptoBird)
            }

            // assert that our new array result will equal our expected result 
            let expected = ['https...1','https...2','https...3','https...4']
            assert.equal(result.join(','), expected.join(','))

        })
        
    })

})