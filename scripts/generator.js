const {StandardMerkleTree} = require("@openzeppelin/merkle-tree");
const fs = require("fs");
const csv = require("csv-parser");

let rows = [];
fs.createReadStream('scripts/airdrop.csv')
  .pipe(csv())
  .on('data', (data) => rows.push(data))
  .on('end', () => {
    let values = rows.map(row => [row.address, row.amount]);
    const tree = StandardMerkleTree.of(values, ["address", "uint256"]);

    console.log('Merkle Root:', tree.root);

    fs.writeFileSync("out/tree_out.json", JSON.stringify(tree.dump()));
    console.log('Tree dumped to out/tree_out.json')
  });
