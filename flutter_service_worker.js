'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "9e5937fb0a35ef0bb56eaf3d6d6e7965",
"assets/AssetManifest.bin.json": "08901e46900dcd25e414d6bda93b7518",
"assets/AssetManifest.json": "2b0b189290229c8471cc5aeebbe6e577",
"assets/assets/api-data.json": "1a3013e2ef573d5b3a7ba60212618704",
"assets/assets/Artificial%2520Intelligence/quizzes/AI_Applications.json": "34d41f49a77c660b1f1d62800a665c79",
"assets/assets/Artificial%2520Intelligence/quizzes/AI_Ethics_and_Governance.json": "39b4c42b49237d463396c381304b8ee5",
"assets/assets/Artificial%2520Intelligence/quizzes/AI_Fundamentals.json": "7cabd54769998e9470e83febb0b77cc3",
"assets/assets/Artificial%2520Intelligence/quizzes/AI_Model_Deployment.json": "c6c34b2c5c7704c57bbfff94b455a3d5",
"assets/assets/Artificial%2520Intelligence/quizzes/AI_System_Design.json": "93df9e22213311d900b7948898609699",
"assets/assets/Artificial%2520Intelligence/quizzes/Computer_Vision.json": "359815565d5d9675ab70717c4a1ed625",
"assets/assets/Artificial%2520Intelligence/quizzes/Computer_Vision_AI.json": "74a9b63e63cfa6fa9b644d749f72d207",
"assets/assets/Artificial%2520Intelligence/quizzes/Future_of_AI.json": "57dcac4958ee2ef6aa37102bd0a49bea",
"assets/assets/Artificial%2520Intelligence/quizzes/Generative_AI.json": "028864a8927408771b2fd0e401c8d135",
"assets/assets/Artificial%2520Intelligence/quizzes/Natural_Language_Processing_AI.json": "27826ea1b2baf0d86fd7acef6c154aab",
"assets/assets/Artificial%2520Intelligence/quizzes/Neural_Networks.json": "accc0088e3a8a1b2d6c5d8bdeda5bacf",
"assets/assets/Blockchain/quizzes/Blockchain_Architecture.json": "ed8d9c905ebf34dfaaf7c8ea224b3c55",
"assets/assets/Blockchain/quizzes/Blockchain_Fundamentals.json": "7deeea3a81b6a49e823b2631c6dffc49",
"assets/assets/Blockchain/quizzes/Blockchain_Platforms.json": "a2d670cebd8ee7a5f23db4887d324733",
"assets/assets/Blockchain/quizzes/Blockchain_Use_Cases.json": "58fc67041d4af84c1cc20e836064c45a",
"assets/assets/Blockchain/quizzes/Consensus_Mechanisms.json": "e3cd40827f428ce9b13ba15be438b7a9",
"assets/assets/Blockchain/quizzes/Cryptography_and_Security.json": "128da554ab7ecee3453bfc736e7cef5e",
"assets/assets/Blockchain/quizzes/Decentralized_Applications.json": "45fba4caf9b031b1bdbee6af997bf5a1",
"assets/assets/Blockchain/quizzes/Future_of_Blockchain.json": "298fc986797f8019144b29f537e88a68",
"assets/assets/Blockchain/quizzes/Smart_Contracts.json": "b97e1afee6e0f392ea942ad5e699cf1b",
"assets/assets/Blockchain/quizzes/Web3_Development.json": "160894408474094dfefa38cf101f2a48",
"assets/assets/blog_data.json": "856b13ac77a2366ef380ee24ffa3de9b",
"assets/assets/Cloud%2520Computing/quizzes/Cloud_Architecture_Design.json": "84a87c984cadf54ee23569df374237c1",
"assets/assets/Cloud%2520Computing/quizzes/Cloud_Cost_Management.json": "69f8dde85bb9961d12402c76ccbf33dc",
"assets/assets/Cloud%2520Computing/quizzes/Cloud_Deployment_Models.json": "b7bfd1c4a727a1e718e59bdfdf4906c1",
"assets/assets/Cloud%2520Computing/quizzes/Cloud_Fundamentals.json": "d61171d8ccef5ac5a85437a0172b6dee",
"assets/assets/Cloud%2520Computing/quizzes/Cloud_Infrastructure_Management.json": "dc8a8a4117da78d50c43d94afc0feae6",
"assets/assets/Cloud%2520Computing/quizzes/Cloud_Migration_and_Integration.json": "f73165ce4b9d52c44ff9b0607f14e67f",
"assets/assets/Cloud%2520Computing/quizzes/Cloud_Networking.json": "a637b753e2f77b8960b8bc2607ff1f1d",
"assets/assets/Cloud%2520Computing/quizzes/Cloud_Security_and_Compliance.json": "9b50a34a61928e50d71d709ec94f675c",
"assets/assets/Cloud%2520Computing/quizzes/Cloud_Service_Models.json": "dc664c77c6fdfa91b1490cbbed0fddc4",
"assets/assets/Cloud%2520Computing/quizzes/Cloud_Storage_Solutions.json": "b1cbabe084a03f0579daf77743324b65",
"assets/assets/Cloud%2520Computing/quizzes/Containerization_and_Orchestration.json": "48431f8865e1122e72d17172c11dc2d1",
"assets/assets/Cloud%2520Computing/quizzes/DevOps_in_Cloud.json": "f6a1212be3a74e46d081dbc376d32bac",
"assets/assets/Cloud%2520Computing/quizzes/Multi_Cloud_Strategies.json": "ef32b8755bcb8006fcb4fd9ec248a883",
"assets/assets/Cloud%2520Computing/quizzes/Serverless_Computing.json": "740552d0c170aa249bf2ef36d1a60409",
"assets/assets/course_images/Data%2520Analytics.jpeg": "d2dc1d4d45e2c928508423e0ecbbcbe8",
"assets/assets/course_images/Data%2520Science.jpeg": "d2dc1d4d45e2c928508423e0ecbbcbe8",
"assets/assets/course_images/Machine%2520Learning.jpeg": "613bce524f4f14aee60b44cae9768827",
"assets/assets/course_images/Numpy.jpeg": "d2dc1d4d45e2c928508423e0ecbbcbe8",
"assets/assets/course_images/Pandas.jpeg": "d2dc1d4d45e2c928508423e0ecbbcbe8",
"assets/assets/course_images/Python%2520Programming.jpeg": "6c494598df48fa5f7dfe710546f7e515",
"assets/assets/course_images/Web%2520Development.jpeg": "78aa7c20bc37430b846f12e47ef6505f",
"assets/assets/course_list.json": "4458b6d93761cf16797508d57849db2e",
"assets/assets/Cybersecurity/quizzes/Application_Security.json": "93f6be6e3d168231dd5c0d28806f87d2",
"assets/assets/Cybersecurity/quizzes/Cloud_Security.json": "ed30e6192ddd1cb65ea39c40bb800071",
"assets/assets/Cybersecurity/quizzes/Cryptography.json": "1ab17ab8a99669588277c497c9fe09ae",
"assets/assets/Cybersecurity/quizzes/Ethical_Hacking.json": "31ff8d78288ae701f40b6edf95bd6006",
"assets/assets/Cybersecurity/quizzes/Incident_Response.json": "dd1049160ab063afe1554ea2f07238cc",
"assets/assets/Cybersecurity/quizzes/Network_Security.json": "344d4a8732cb64ef0b0f6e4457396d72",
"assets/assets/Cybersecurity/quizzes/Security_Compliance.json": "bbd4b563f20533427bfc18ad9ebb20f6",
"assets/assets/Cybersecurity/quizzes/Security_Fundamentals.json": "ccf07150abf0c73d7c08836b5154176e",
"assets/assets/Cybersecurity/quizzes/Security_Operations.json": "f98fde44cea537a6622a8a7589189086",
"assets/assets/Cybersecurity/quizzes/Threat_Intelligence.json": "617654fed667b9a2dd10f66238b60674",
"assets/assets/Data%2520Analytics/quizzes/Big_Data_Management_and_Analytics.json": "188f872ed397e9256c58f62f3813f97f",
"assets/assets/Data%2520Analytics/quizzes/Data_Analytics_Lifecycle.json": "fc7b98671e15a537beea685688c76ce1",
"assets/assets/Data%2520Analytics/quizzes/Data_Quality_and_Governance.json": "81ce0f0b27de5a87f2c04e37cad1ecb3",
"assets/assets/Data%2520Analytics/quizzes/Data_Visualization_and_Communication.json": "7fec2ca011df416f470fa64d8d9631a6",
"assets/assets/Data%2520Analytics/quizzes/Data_Warehousing_and_ETL.json": "07c4d861f5f09484fd0042be41212cc4",
"assets/assets/Data%2520Analytics/quizzes/Exploratory_Data_Analysis.json": "9a13f981559d339da478837fab54fcab",
"assets/assets/Data%2520Analytics/quizzes/Predictive_Modeling_Techniques.json": "a1dfe6130a1666df7a6c64c3542c0abd",
"assets/assets/Data%2520Analytics/quizzes/Statistical_Foundations_for_Analytics.json": "6d6e719708d813caf5252ee70b41e3d8",
"assets/assets/Data%2520Science/quizzes/Databases_and_Big_Data_Technologies.json": "1998b02598e0f42ffc75744008d5ffbc",
"assets/assets/Data%2520Science/quizzes/Data_Collection_and_Preparation.json": "e52b799b6b2717329b1772f8bad4d59f",
"assets/assets/Data%2520Science/quizzes/Data_Mining_and_Data_Wrangling.json": "4072f86e81668795cb0927448974a34b",
"assets/assets/Data%2520Science/quizzes/Data_Science_Fundamentals.json": "1926b2a6803e114b0c3ab360d8224b72",
"assets/assets/Data%2520Science/quizzes/Data_Visualization.json": "ec6cf17d4a853d227baf1d14ceb6423a",
"assets/assets/Data%2520Science/quizzes/Deep_Learning.json": "b6bf1183a5c8426c38d0bf87500449c7",
"assets/assets/Data%2520Science/quizzes/Domain_Specific_Applications.json": "627ea6c10fbd8bb1e300bacab8de78ea",
"assets/assets/Data%2520Science/quizzes/Ethics_and_Data_Privacy.json": "42da2d9ab041bf37d33867ae415320da",
"assets/assets/Data%2520Science/quizzes/Exploratory_Data_Analysis.json": "f38ab2368fe998d5938bf4052ffda674",
"assets/assets/Data%2520Science/quizzes/Machine_Learning.json": "6dd99bdbb20d4d5d70e828309a11bdb7",
"assets/assets/Data%2520Science/quizzes/Statistics_and_Probability.json": "434edf3e01d56f395106909712ff1321",
"assets/assets/Data%2520Structures%2520and%2520Algorithms/quizzes/Advanced_Data_Structures.json": "b8bc2ff471ad6ba759742b0740be85d6",
"assets/assets/Data%2520Structures%2520and%2520Algorithms/quizzes/Algorithm_Analysis.json": "6e47bdaae8cb644ce38894074b577b20",
"assets/assets/Data%2520Structures%2520and%2520Algorithms/quizzes/Algorithm_Design_Techniques.json": "91d8b8f490325c12c792a2fe90e96d86",
"assets/assets/Data%2520Structures%2520and%2520Algorithms/quizzes/Basic_Data_Structures.json": "2b956eb22c385273526a0f484e4fdab8",
"assets/assets/Data%2520Structures%2520and%2520Algorithms/quizzes/Competitive_Programming.json": "39b70d54203e5da82d1325cb6ba849f0",
"assets/assets/Data%2520Structures%2520and%2520Algorithms/quizzes/Dynamic_Programming.json": "0d8875b2838be37df173315b9efb2ab4",
"assets/assets/Data%2520Structures%2520and%2520Algorithms/quizzes/Graph_Algorithms.json": "12c04649de0c190d259c54a925c3d242",
"assets/assets/Data%2520Structures%2520and%2520Algorithms/quizzes/Greedy_Algorithms.json": "dc7e027dec0164101bc132db5d0c2a33",
"assets/assets/Data%2520Structures%2520and%2520Algorithms/quizzes/Interview_Preparation.json": "176d6d9d77e1001c43007ecb89da0fe2",
"assets/assets/Data%2520Structures%2520and%2520Algorithms/quizzes/Problem_Solving_Strategies.json": "d8de9a7d1dc1b60e05b4958a560693c9",
"assets/assets/Data%2520Structures%2520and%2520Algorithms/quizzes/Sorting_and_Searching.json": "6e51745e27873393106239b767c516ec",
"assets/assets/Data%2520Structures%2520and%2520Algorithms/quizzes/Space_Time_Complexity.json": "acd446205804b2c83d75457ebe024304",
"assets/assets/Data%2520Structures%2520and%2520Algorithms/quizzes/String_Algorithms.json": "137cea95600edf464c1a71e1660ae716",
"assets/assets/Data%2520Structures%2520and%2520Algorithms/quizzes/Tree_Algorithms.json": "f6fb4845cf91c90f1fdbdd1cffac3456",
"assets/assets/DevOps/quizzes/Cloud_DevOps.json": "2df467e9d9fc873479b4db8e626071fb",
"assets/assets/DevOps/quizzes/Configuration_Management.json": "b5d971624ae88a7dc49e933fc3329163",
"assets/assets/DevOps/quizzes/Continuous_Deployment.json": "c72ff914db5c7ac4e7b25c040985073a",
"assets/assets/DevOps/quizzes/Continuous_Integration.json": "aad0fc01fc5163c02fa2867cfce3e5d2",
"assets/assets/DevOps/quizzes/DevOps_Best_Practices.json": "0fd983501ad29f5c238005cd362773fb",
"assets/assets/DevOps/quizzes/DevOps_Fundamentals.json": "ed1c5956e25421ccf4298f52afd3f26e",
"assets/assets/DevOps/quizzes/DevOps_Security.json": "bd4abce2a273ff72fcad6333c5c1910a",
"assets/assets/DevOps/quizzes/DevOps_Tools_and_Automation.json": "c4855132b6052596734be8c0919ba25c",
"assets/assets/DevOps/quizzes/Infrastructure_as_Code.json": "46813a2e5f997d78ad2fbc7c38457faa",
"assets/assets/DevOps/quizzes/Monitoring_and_Logging.json": "570d1fe0ac3259210a83845a069228c2",
"assets/assets/Docker/quizzes/Container_Basics.json": "fb36696c4fa02932c17c048291d8655d",
"assets/assets/Docker/quizzes/Container_Lifecycle_Management.json": "69b90962c08ef5eed0b1f0905359355c",
"assets/assets/Docker/quizzes/Dockerfile_and_Image_Creation.json": "954c42e016875065592a11697a20ddda",
"assets/assets/Docker/quizzes/Docker_Best_Practices.json": "aa274cd35279d08920b61953b8f4ee0e",
"assets/assets/Docker/quizzes/Docker_Compose.json": "081a10c0cc41f220ef8b207657168e57",
"assets/assets/Docker/quizzes/Docker_Fundamentals.json": "fba3a4d0bb08cc31a77140a9b56da7a9",
"assets/assets/Docker/quizzes/Docker_in_Production.json": "969b6ea6154a37e46c659e137c2db47b",
"assets/assets/Docker/quizzes/Docker_Monitoring_and_Logging.json": "196d526e1baa520e1c80f5675f4d40a5",
"assets/assets/Docker/quizzes/Docker_Networking.json": "4dfc2117b11d432a19642075b34243a3",
"assets/assets/Docker/quizzes/Docker_Registry_and_Distribution.json": "f06691bf46f2846fe4f810d73140964a",
"assets/assets/Docker/quizzes/Docker_Security.json": "730e4c9cfdd2d980716e2c77366ff39f",
"assets/assets/Docker/quizzes/Docker_Storage_and_Volumes.json": "554413bfb2e037a918b95a5ece12057d",
"assets/assets/explore.json": "76c0c9f252c6e278bfe6ac4d9c953d78",
"assets/assets/faqs.json": "36105de58a4b1099557a83c2698c7bdf",
"assets/assets/files.js": "8b8c865c2de7aca4af5b1ad0152710c3",
"assets/assets/Internet%2520of%2520Things/quizzes/Edge_Computing.json": "b67548e162b31525947fbd19d078a97c",
"assets/assets/Internet%2520of%2520Things/quizzes/Future_of_IoT.json": "5280d4ed9560d68999829e95e842861e",
"assets/assets/Internet%2520of%2520Things/quizzes/IoT_Applications.json": "67ed2c4b35e6cbd4ca39c0308d105b10",
"assets/assets/Internet%2520of%2520Things/quizzes/IoT_Architecture.json": "56a321159343989ea7a88bc0db67aa3d",
"assets/assets/Internet%2520of%2520Things/quizzes/IoT_Data_Analytics.json": "a645e7592e621d28e9bf4dbb2111e2d7",
"assets/assets/Internet%2520of%2520Things/quizzes/IoT_Fundamentals.json": "b3905696a5a049c134eecc97fba3d5d8",
"assets/assets/Internet%2520of%2520Things/quizzes/IoT_Platforms.json": "38fb334aa4ba0b716665e621d201f963",
"assets/assets/Internet%2520of%2520Things/quizzes/IoT_Protocols.json": "443b621baeaa7a0f6c3768b6d6edd57d",
"assets/assets/Internet%2520of%2520Things/quizzes/IoT_Security.json": "7287f5f0f18b1838308b53a97d18c4a1",
"assets/assets/Internet%2520of%2520Things/quizzes/Sensors_and_Actuators.json": "962bc76c947e83b15711ee560ea0cd4a",
"assets/assets/Kubernetes/quizzes/Advanced_Kubernetes_Concepts.json": "c41d484db47daa7e443a7aabce8e2902",
"assets/assets/Kubernetes/quizzes/CI_CD_with_Kubernetes.json": "a08aff1d2418e36bc4b91c54ca3c4044",
"assets/assets/Kubernetes/quizzes/Cluster_Management.json": "23fd7b685a22dddfe0aea1abf6af9f10",
"assets/assets/Kubernetes/quizzes/Configuration_and_Security.json": "bea1ada60f76d34d471fbd69cbfe8721",
"assets/assets/Kubernetes/quizzes/Deployments_and_StatefulSets.json": "2a5c5c5b85abead7c56e36f9de675df4",
"assets/assets/Kubernetes/quizzes/Kubernetes_Architecture.json": "96b9f37ad7f37a6a397db82d29f13a47",
"assets/assets/Kubernetes/quizzes/Monitoring_and_Logging.json": "a12cc8b234b2f2ceca5fbf2f3016d279",
"assets/assets/Kubernetes/quizzes/Pod_Lifecycle_and_Design.json": "a20c3793c8a5fe57fc84f2c8701bced8",
"assets/assets/Kubernetes/quizzes/Resource_Management.json": "10b589036c7d0c9d5fb4525c6b460b9b",
"assets/assets/Kubernetes/quizzes/Scaling_and_Performance.json": "71cf59ed27491336dea78b330b1b05f7",
"assets/assets/Kubernetes/quizzes/Services_and_Networking.json": "4bb03e8e7bb855dd67feb064c43bcda7",
"assets/assets/Kubernetes/quizzes/Storage_and_Persistence.json": "8b95481a3c36f982ea8a6a7bfcda30a8",
"assets/assets/Machine%2520Learning/quizzes/Advanced_Topics_in_ML.json": "1336d699f39a080102a710a66ee5c0e9",
"assets/assets/Machine%2520Learning/quizzes/Computer_Vision.json": "6554fe2cbf4e6d3700a6d06fa29479a4",
"assets/assets/Machine%2520Learning/quizzes/Deep_Learning_Foundations.json": "d06e4e129d39f281087f20c8e0680e2f",
"assets/assets/Machine%2520Learning/quizzes/Deployment_and_Productionization.json": "a476f6d10a9f899c984db328aea3e68d",
"assets/assets/Machine%2520Learning/quizzes/Dimensionality_Reduction.json": "a09d2bda2818bd452b998067e417db4c",
"assets/assets/Machine%2520Learning/quizzes/Ethical_Considerations_in_ML.json": "7371c7963b951b64179b625214fe0d1b",
"assets/assets/Machine%2520Learning/quizzes/Feature_Engineering_and_Selection.json": "00ce10f840f05844e62c48bb5acd62f8",
"assets/assets/Machine%2520Learning/quizzes/Machine_Learning_Fundamentals.json": "02e8cfe0bee9a2d3649e26df449036ed",
"assets/assets/Machine%2520Learning/quizzes/Model_Evaluation_and_Selection.json": "da9f2dfc14bdafb71534261151f06560",
"assets/assets/Machine%2520Learning/quizzes/Natural_Language_Processing.json": "3c549c9ac5e8cc3a961379a79ef4cb03",
"assets/assets/Machine%2520Learning/quizzes/Reinforcement_Learning.json": "9f55044dde3e40ab4368359ddf47c66f",
"assets/assets/Machine%2520Learning/quizzes/Supervised_Learning.json": "525f68f5584e0d75dd3cc61515015549",
"assets/assets/Machine%2520Learning/quizzes/Time_Series_Analysis.json": "1923231514310ca3a3d525f2305ed275",
"assets/assets/Machine%2520Learning/quizzes/Unsupervised_Learning.json": "47b2ac000dc64d2690abc67a18f16c90",
"assets/assets/mentors.json": "f1a14c41eb74b267251802ecafb62a85",
"assets/assets/names.txt": "af65a20dfaa90e60f0b3570d3af3f686",
"assets/assets/Numpy/quizzes/Advanced_Topics.json": "62ff9c8a7d2fe958d7ad3dcd314fa3e6",
"assets/assets/Numpy/quizzes/Array_Indexing_and_Slicing.json": "ab44bed0fd930fcddd77516e5dab34cd",
"assets/assets/Numpy/quizzes/Array_Manipulation.json": "9753d3df5cf2e89ac077578da6697e36",
"assets/assets/Numpy/quizzes/Basic_Array_Operations.json": "5ff6844fffe9bf8e2aae5bcef29fb853",
"assets/assets/Numpy/quizzes/Broadcasting.json": "b12da71a1799dcd5cd0b52c261dc234e",
"assets/assets/Numpy/quizzes/Creating_NumPy_Arrays.json": "a828b5f6fe9d5e84dcdbe45f23d9c91e",
"assets/assets/Numpy/quizzes/Introduction_to_NumPy.json": "53b154c274e68f633bbaac21b51277ee",
"assets/assets/Numpy/quizzes/Mathematical_Functions.json": "1e7ff249061cb6129fe7513696e06044",
"assets/assets/Numpy/quizzes/Working_with_Files.json": "d0f3e838989d2c6e6d9d104ad50bc93a",
"assets/assets/Pandas/quizzes/Creating_and_Reading_Data.json": "c5bb82f558bb9ed135c97d10bc9a4d5c",
"assets/assets/Pandas/quizzes/Data_Aggregation_and_Grouping.json": "339fda023afe6d383cfa67f93f8a4161",
"assets/assets/Pandas/quizzes/Data_Cleaning.json": "ea610c206ef4f97da8a337cfb3e6b07c",
"assets/assets/Pandas/quizzes/Data_Exploration.json": "14b3d73e414c7f1cbe7c56622ce099cc",
"assets/assets/Pandas/quizzes/Data_Manipulation.json": "5fae1faca5431266598182d98a95bb14",
"assets/assets/Pandas/quizzes/Data_Visualization.json": "1574965fe29a490b17c3d032c86d532f",
"assets/assets/Pandas/quizzes/Introduction_to_Pandas.json": "1f39a2072223587d7ff539ba81bdee9a",
"assets/assets/Pandas/quizzes/Merging_and_Joining_Data.json": "a46d302059ad9084f04d2d02305ae988",
"assets/assets/Pandas/quizzes/Time_Series_Data.json": "5ef1e93318ec2f7f3fbde29e8cb321a8",
"assets/assets/Personality%2520Development/quizzes/Communication_Skills.json": "fddeb05a7693183fdf74aa8a1ed36de1",
"assets/assets/Personality%2520Development/quizzes/Conflict_Resolution.json": "f44ed1eb6e26b795a657494721e24f4a",
"assets/assets/Personality%2520Development/quizzes/Emotional_Intelligence.json": "a182a74d8b9cdb315637e47509a1beb4",
"assets/assets/Personality%2520Development/quizzes/Goal_Setting_and_Achievement.json": "955245aa199c8b914155d4a7c8ebaf82",
"assets/assets/Personality%2520Development/quizzes/Leadership_Development.json": "127ed0b899c621daad8fd6c7a0a4c7b5",
"assets/assets/Personality%2520Development/quizzes/Networking_Skills.json": "b8149c59768d038152bcc6827438a7e4",
"assets/assets/Personality%2520Development/quizzes/Personal_Branding.json": "ea7da3a2fb30ad4c9040af120de0ad89",
"assets/assets/Personality%2520Development/quizzes/Professional_Etiquette.json": "b8943878533da7524b6aed0e5754204f",
"assets/assets/Personality%2520Development/quizzes/Public_Speaking.json": "88b25dba05e09e4c355ffa60d5b9eb33",
"assets/assets/Personality%2520Development/quizzes/Self_Awareness_and_Growth.json": "01025432c445071ebc87cbbc9a661858",
"assets/assets/Personality%2520Development/quizzes/Stress_Management.json": "442b713a3d91e9c80a8cda05f07a5bcd",
"assets/assets/Personality%2520Development/quizzes/Team_Building.json": "caee262895acf66593c8befbf8ec64cb",
"assets/assets/Personality%2520Development/quizzes/Time_Management.json": "b5bdad6fe0c7ae4df8acaed4896cdb0f",
"assets/assets/Personality%2520Development/quizzes/Work_Life_Balance.json": "5a6f666eb1107e355a92dd367bac318f",
"assets/assets/Prompt%2520Engineering/quizzes/Advanced_Prompting_Techniques.json": "5cae31aa0e05f370ea5a0e0625e7914e",
"assets/assets/Prompt%2520Engineering/quizzes/Chain_of_Thought_Prompting.json": "0d1bfdd933cdac2786474845a022e833",
"assets/assets/Prompt%2520Engineering/quizzes/Context_and_Instructions.json": "ac873098ee9179405b8a4ad9d3d95d9e",
"assets/assets/Prompt%2520Engineering/quizzes/Ethics_and_Best_Practices.json": "9c8456270c25576839c204f1ac4fe6e3",
"assets/assets/Prompt%2520Engineering/quizzes/Few_Shot_Learning.json": "0979fd78435e8098e2fbe016c41dcf9c",
"assets/assets/Prompt%2520Engineering/quizzes/Fundamentals_of_Prompt_Engineering.json": "6b54f58cdbc6b8954483c5cc80ea40c0",
"assets/assets/Prompt%2520Engineering/quizzes/Output_Formatting_and_Control.json": "319f8111833490858c5587b717e15be9",
"assets/assets/Prompt%2520Engineering/quizzes/Prompt_Design_Patterns.json": "a400545a6aa0e5a64ceffde5be06a05d",
"assets/assets/Prompt%2520Engineering/quizzes/Prompt_Testing_and_Iteration.json": "5b87ca4c6925430689df2166caadfe86",
"assets/assets/Prompt%2520Engineering/quizzes/System_and_User_Roles.json": "98ee02cb713752fe5795ae11ed276554",
"assets/assets/Python%2520Programming/quizzes/advanced.json": "5a80cdb4940bc617ab7110be45d240e1",
"assets/assets/Python%2520Programming/quizzes/applications.json": "6fdc1331faad01ed780e0ec9f43c0643",
"assets/assets/Python%2520Programming/quizzes/control_flow.json": "193cde68b9e8fa0e91bfe5ee23b4fefc",
"assets/assets/Python%2520Programming/quizzes/data_structures.json": "92fdcd28229399efd5761bba2d422986",
"assets/assets/Python%2520Programming/quizzes/error_handling.json": "97b840bfcfa8d6c5506644e2eafeca8b",
"assets/assets/Python%2520Programming/quizzes/files.json": "5d14ca878b84bd95fbb6bce8c742407e",
"assets/assets/Python%2520Programming/quizzes/functions.json": "e1d3d5a4d43fac49e60190fc583f4169",
"assets/assets/Python%2520Programming/quizzes/intro.json": "2415873f7bcc7ff2fc3e3e33bd5b3864",
"assets/assets/Python%2520Programming/quizzes/modules.json": "b68708623218e3e607405f222a355579",
"assets/assets/Python%2520Programming/quizzes/oops.json": "938f0175fcb18e0ee270aff9cfc9e827",
"assets/assets/Software%2520Testing/quizzes/CI_CD_Integration.json": "bc778128486f4bce5d1c2717f8e0d670",
"assets/assets/Software%2520Testing/quizzes/Compatibility_Testing.json": "20c8099a5aadccdec65ad52521668fc9",
"assets/assets/Software%2520Testing/quizzes/Defect_Management.json": "ed76ef1204c611d57fd121dfb4eb0d39",
"assets/assets/Software%2520Testing/quizzes/Functional_NonFunctional_Testing.json": "f1318d5e0748186f646f79ab83059643",
"assets/assets/Software%2520Testing/quizzes/Intro_to_Testing.json": "89903e463947afd999d8e8fd5c834b5f",
"assets/assets/Software%2520Testing/quizzes/Performance_Testing.json": "4dca9eb6191361d4991be92736e2d2f9",
"assets/assets/Software%2520Testing/quizzes/Regression_Exploratory_Testing.json": "16545bc2a560dc1030a987356c35453e",
"assets/assets/Software%2520Testing/quizzes/Security_Usability_Testing.json": "2c921c7ac29765bd861f83fa87e57f0c",
"assets/assets/Software%2520Testing/quizzes/System_Acceptance_Testing.json": "0953a7d4378ebab48e2bc48f6b481d95",
"assets/assets/Software%2520Testing/quizzes/Testing_Levels.json": "ecc4f58fd7dc77caf9bc7c84bb579989",
"assets/assets/Software%2520Testing/quizzes/Test_Automation.json": "eea3963edcc8547084a357976c3c54e6",
"assets/assets/Software%2520Testing/quizzes/Test_Data_Management.json": "b7dd6c12f7c95c0d16f0bca948a0f03d",
"assets/assets/Software%2520Testing/quizzes/Test_Design_Execution.json": "3c735fdab66700d1bf1045642dbe089b",
"assets/assets/Software%2520Testing/quizzes/Test_Reporting_Analytics.json": "88abe511425b46aa29dc79694f726dce",
"assets/assets/Software%2520Testing/quizzes/Unit_Integration_Testing.json": "f0345f5e2f2acbddfd8b91b0e267626e",
"assets/assets/student_home/qrcode.jpg": "bb15dcae08e75ee837eaa40f51112ad5",
"assets/assets/student_home/sfcmp.png": "62aa2a5c327025b8c04d34c76626f7cc",
"assets/assets/student_home/sf_home_1.png": "e8f726c374db3837ae9cfd0694c6638f",
"assets/assets/student_home/sf_home_2.png": "a13e5bae3fa2eb43a777fe9c6869c537",
"assets/assets/universities.json": "d15718fa20a6934dd22346bc7896d7dd",
"assets/assets/Web%2520Development/quizzes/css_advanced.json": "b05660a0e2d5046bb312f568895b46bb",
"assets/assets/Web%2520Development/quizzes/css_intro.json": "5c1bb742461035e360a00ace7c1354eb",
"assets/assets/Web%2520Development/quizzes/css_responsive.json": "38993007b4aa1c5cd1d571faf9c1ca2f",
"assets/assets/Web%2520Development/quizzes/html_apis.json": "67a1aa5841c5148625a0f3f50b39386a",
"assets/assets/Web%2520Development/quizzes/html_forms.json": "5bb7da1640e3b82fba94a9befeffbc5a",
"assets/assets/Web%2520Development/quizzes/html_intro.json": "0a1cd4dca0dacf6ea297a3b80c54cace",
"assets/assets/Web%2520Development/quizzes/html_media.json": "a14345eea18aed36f1044261aededcee",
"assets/assets/Web%2520Development/quizzes/js_apis.json": "b9ba733cc54b2d2977433507795e5952",
"assets/assets/Web%2520Development/quizzes/js_async.json": "d4856c1c018cb8cc27ae59f258a2abcf",
"assets/assets/Web%2520Development/quizzes/js_bom.json": "a3b97298f58711a34528dbbc109f7bb7",
"assets/assets/Web%2520Development/quizzes/js_intro.json": "b449a0ec887486e5eaf469ced00760d8",
"assets/FontManifest.json": "5a32d4310a6f5d9a6b651e75ba0d7372",
"assets/fonts/MaterialIcons-Regular.otf": "cc3bd3be3593f74bb4855b9fe4ad9c1f",
"assets/NOTICES": "cb47c33bb2073f8c0cfb3120ea5a01cf",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "283f629835fb880f0b63b2d470935d4d",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "c2f61e1189891f07a692be9efa2d2150",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "3fb2f56397c2a0fb86ea6872c6145842",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "66177750aff65a66cb07bb44b8c6422b",
"canvaskit/canvaskit.js.symbols": "48c83a2ce573d9692e8d970e288d75f7",
"canvaskit/canvaskit.wasm": "1f237a213d7370cf95f443d896176460",
"canvaskit/chromium/canvaskit.js": "671c6b4f8fcc199dcc551c7bb125f239",
"canvaskit/chromium/canvaskit.js.symbols": "a012ed99ccba193cf96bb2643003f6fc",
"canvaskit/chromium/canvaskit.wasm": "b1ac05b29c127d86df4bcfbf50dd902a",
"canvaskit/skwasm.js": "694fda5704053957c2594de355805228",
"canvaskit/skwasm.js.symbols": "262f4827a1317abb59d71d6c587a93e2",
"canvaskit/skwasm.wasm": "9f0c0c02b82a910d12ce0543ec130e60",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c",
"favicon.png": "8643c20c190144cfb0460cadbf8e0604",
"flutter.js": "f393d3c16b631f36852323de8e583132",
"flutter_bootstrap.js": "c96a6d1fa6a5f06b022199bd44182020",
"icons/Icon-192.png": "9b9147761b789428e0bc90a976b1fcb5",
"icons/Icon-512.png": "d50db7cacaba6f3fff5c9d13b283d428",
"icons/Icon-maskable-192.png": "9b9147761b789428e0bc90a976b1fcb5",
"icons/Icon-maskable-512.png": "d50db7cacaba6f3fff5c9d13b283d428",
"index.html": "79e261630a92eba85ff12c6578c319e1",
"/": "79e261630a92eba85ff12c6578c319e1",
"main.dart.js": "90e508d07a85b2aa1b32158ef9dcb4e1",
"manifest.json": "7e48f1849e1583eb1ef555a3858e8b54",
"version.json": "900445f2862463ceb58ffd4b5de97cb4"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
