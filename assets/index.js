// const fs = require("fs");

// // Using readdir (asynchronous)
// fs.readdir("./audioFiles", (err, files) => {
//   if (err) {
//     console.error(err);
//     return;
//   }

//   console.log(files); // Array of filenames
// });

const fs = require("fs");
const path = require("path");

function listFiles(dir) {
  const files = fs.readdirSync(dir);
  let fileList = [];

  files.forEach((file) => {
    const filePath = path.join(dir, file);
    const fileStat = fs.statSync(filePath);

    if (fileStat.isDirectory()) {
      const subFiles = listFiles(filePath); // Recursively list files in subdirectory
      fileList = fileList.concat(subFiles);
    } else {
      fileList.push(filePath);
    }
  });

  return fileList;
}

const directory = "./Web Development";
const files = listFiles(directory);

const filePaths = files.map((e) => e.replace(/\\/g, "/"));
// const filePaths = files.map((filePath) => filePath.replace(/\\/g, "/"));
console.log(filePaths);
