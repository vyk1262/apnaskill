const fs = require("fs");
const path = require("path");

function createJsonFiles(inputFile, outputDir = ".") {
  let names = [];
  try {
    const inputFilePath = path.join(__dirname, inputFile);
    const fileContent = fs.readFileSync(inputFilePath, "utf-8");
    names = fileContent
      .split("\n")
      .map((line) => line.trim().replace(/^"|"$/g, ""));
    console.log("Names read from file:", names);
  } catch (error) {
    console.error(`Error reading file: ${error.message}`);
    return;
  }

  // Use path.join to create the 'jsonFiles' directory
  const jsonFilesDir = path.join(outputDir, "jsonFiles");
  if (!fs.existsSync(jsonFilesDir)) {
    fs.mkdirSync(jsonFilesDir, { recursive: true });
  }

  names.forEach((name) => {
    if (name) {
      // Add this check
      const data = {
        result: [
          {
            topic: name,
            questions: [],
          },
        ],
      };
      const filename = `${name.replace(/ /g, "_")}.json`;
      const filepath = path.join(jsonFilesDir, filename); // Save inside jsonFiles directory
      try {
        const jsonData = JSON.stringify(data, null, 4);
        fs.writeFileSync(filepath, jsonData, "utf-8");
        console.log(`Created: ${filepath}`);
      } catch (error) {
        console.error(`Error creating file ${filepath}: ${error}`);
      }
    }
  });
}

// Create a dummy names.txt file for demonstration ONLY if it doesn't exist
const inputFile = "names.txt";
const outputDir = ".";
const inputFilePath = path.join(__dirname, inputFile);
if (!fs.existsSync(inputFilePath)) {
  // Check if the file exists
  fs.writeFileSync(
    inputFilePath,
    `"Data_Analytics_Lifecycle",\n"Data_Warehousing_and_ETL",\n"Data_Quality_and_Governance",\n"Exploratory_Data_Analysis",\n"Data_Visualization_and_Communication",\n"Statistical_Foundations_for_Analytics",\n"Predictive_Modeling_Techniques",\n"Big_Data_Management_and_Analytics"`
  );
}

createJsonFiles(inputFile, outputDir);
