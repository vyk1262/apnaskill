'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "37ffac22555719c499132b3db7fd53d7",
"assets/AssetManifest.bin.json": "3356e4226c4d3ccf7f76ae3b14b25f97",
"assets/AssetManifest.json": "e291e3121f25047879fa0777e6a7a0a2",
"assets/assets/api-data.json": "1a3013e2ef573d5b3a7ba60212618704",
"assets/assets/Artificial%2520Intelligence/quizzes/AI_Applications.json": "34d41f49a77c660b1f1d62800a665c79",
"assets/assets/Artificial%2520Intelligence/quizzes/AI_Ethics_and_Governance.json": "39b4c42b49237d463396c381304b8ee5",
"assets/assets/Artificial%2520Intelligence/quizzes/AI_Fundamentals.json": "84774fc5c64a6096186c59b8a0f047c1",
"assets/assets/Artificial%2520Intelligence/quizzes/AI_Model_Deployment.json": "c6c34b2c5c7704c57bbfff94b455a3d5",
"assets/assets/Artificial%2520Intelligence/quizzes/AI_System_Design.json": "93df9e22213311d900b7948898609699",
"assets/assets/Artificial%2520Intelligence/quizzes/Computer_Vision.json": "359815565d5d9675ab70717c4a1ed625",
"assets/assets/Artificial%2520Intelligence/quizzes/Computer_Vision_AI.json": "74a9b63e63cfa6fa9b644d749f72d207",
"assets/assets/Artificial%2520Intelligence/quizzes/Future_of_AI.json": "57dcac4958ee2ef6aa37102bd0a49bea",
"assets/assets/Artificial%2520Intelligence/quizzes/Generative_AI.json": "028864a8927408771b2fd0e401c8d135",
"assets/assets/Artificial%2520Intelligence/quizzes/Natural_Language_Processing_AI.json": "8c7336b46243670f0790939751bb12ee",
"assets/assets/Artificial%2520Intelligence/quizzes/Neural_Networks.json": "e99a626e3685908d46607b5e6f6a680b",
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
"assets/assets/Chess/quizzes/Advanced_Tactics.json": "6b7f0a9bf789d7a096b4e8d021637666",
"assets/assets/Chess/quizzes/Basic_Rules_and_Moves.json": "593a85f3ce5c8cc5f507fd5c49bff04b",
"assets/assets/Chess/quizzes/Board_Setup_and_Pieces.json": "252c6d4bb415fce0ee1406bcbc56f663",
"assets/assets/Chess/quizzes/Chess_Fundamentals.json": "1b03ce71ccf603e6576c4f007748c23f",
"assets/assets/Chess/quizzes/Chess_Psychology.json": "ff19cc64a96e7a3044a81ae4076c5d79",
"assets/assets/Chess/quizzes/End_Game_Techniques.json": "ead0bac571359e0148d9d358e6c22eb4",
"assets/assets/Chess/quizzes/Game_Analysis.json": "fdfec9c6abd4aabe0fef379d4f42bfdc",
"assets/assets/Chess/quizzes/Middle_Game_Strategies.json": "67e224523f9c4f8ef5b60bb3523e8842",
"assets/assets/Chess/quizzes/Opening_Principles.json": "676857616735a9ffa0234b2c58faba91",
"assets/assets/Chess/quizzes/Strategic_Planning.json": "4a98c6d4c4ec34fda54ed9591ef70544",
"assets/assets/Chess/quizzes/Tactical_Patterns.json": "c7b27d03ff42a13621de7e85436400fb",
"assets/assets/Chess/quizzes/Tournament_Play.json": "8c3e414989db54318b2edaa728c1d7a0",
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
"assets/assets/course_list.json": "552e1e71b5989140dc58f145deeeffb2",
"assets/assets/CSS/quizzes/css_advanced.json": "b3bc63f4631ab87f27aedadd1e35a4fc",
"assets/assets/CSS/quizzes/css_intro.json": "03cedb48e85858b9ed62c25fdcddff09",
"assets/assets/CSS/quizzes/css_responsive.json": "6ea93299d988f1bff74a04a978584464",
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
"assets/assets/Data%2520Analytics/quizzes/Big_Data_Management_and_Analytics.json": "f166b001113d7d8bb2ceaa33dbe3bd04",
"assets/assets/Data%2520Analytics/quizzes/Data_Analytics_Lifecycle.json": "fef24a96cb37a0534a5d3a980588ce38",
"assets/assets/Data%2520Analytics/quizzes/Data_Quality_and_Governance.json": "475094daed7a8df74aba00260081e07d",
"assets/assets/Data%2520Analytics/quizzes/Data_Visualization_and_Communication.json": "ab1991c3dcec9331456abe913584be7d",
"assets/assets/Data%2520Analytics/quizzes/Data_Warehousing_and_ETL.json": "5b95086507f083be55375cc1b4a8f870",
"assets/assets/Data%2520Analytics/quizzes/Exploratory_Data_Analysis.json": "df9b45e02fedd1f884d4158121c97caa",
"assets/assets/Data%2520Analytics/quizzes/Predictive_Modeling_Techniques.json": "e73634485b699c43327b2264ea948138",
"assets/assets/Data%2520Analytics/quizzes/Statistical_Foundations_for_Analytics.json": "b5faaf6fdd66c34136286f23ddc90757",
"assets/assets/Data%2520Science/quizzes/Databases_and_Big_Data_Technologies.json": "17a61d9d6c0c193815d8e93e1f0c154e",
"assets/assets/Data%2520Science/quizzes/Data_Collection_and_Preparation.json": "1af620cc8f469bd080ba554c76f8e7ab",
"assets/assets/Data%2520Science/quizzes/Data_Mining_and_Data_Wrangling.json": "850f19f361c56d770dccf2d42adaba01",
"assets/assets/Data%2520Science/quizzes/Data_Science_Fundamentals.json": "039bcab87253b60f719995f2e58efa30",
"assets/assets/Data%2520Science/quizzes/Data_Visualization.json": "badafe53eaeeb85c4d6fc0653a68524e",
"assets/assets/Data%2520Science/quizzes/Deep_Learning.json": "4343d70ee3b6f085fdf987f5e5f00e38",
"assets/assets/Data%2520Science/quizzes/Domain_Specific_Applications.json": "965cb34a466af3519a0e3a6a8467ab58",
"assets/assets/Data%2520Science/quizzes/Ethics_and_Data_Privacy.json": "69a56177643c2b970036f0fdc138b536",
"assets/assets/Data%2520Science/quizzes/Exploratory_Data_Analysis.json": "746af656c3f37c461f2e588aed68b817",
"assets/assets/Data%2520Science/quizzes/Machine_Learning.json": "4c4c95ec598a3b507e12b5dcce053e0b",
"assets/assets/Data%2520Science/quizzes/Statistics_and_Probability.json": "c27e286f98a0a7e0a406d052e77b3c98",
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
"assets/assets/Docker/quizzes/Container_Basics.json": "9e9f2a7fc45b4c709e9fd9c30d8e05fc",
"assets/assets/Docker/quizzes/Container_Lifecycle_Management.json": "72a1f94a9f55dad31be34ff66d668be7",
"assets/assets/Docker/quizzes/Dockerfile_and_Image_Creation.json": "ea52140308753e4b19da229d1d137d58",
"assets/assets/Docker/quizzes/Docker_Best_Practices.json": "e108717c77485847e2d2e2db65dd49b2",
"assets/assets/Docker/quizzes/Docker_Compose.json": "7c7a38a48839355cfa260cc32ca4b80a",
"assets/assets/Docker/quizzes/Docker_Fundamentals.json": "14589e59bcab996b0515d3c7744601db",
"assets/assets/Docker/quizzes/Docker_in_Production.json": "753136e3bf3187987e9bab3d931e7140",
"assets/assets/Docker/quizzes/Docker_Monitoring_and_Logging.json": "1336a6b94ecd773bd9e7f15b20f64067",
"assets/assets/Docker/quizzes/Docker_Networking.json": "46e1c4ab41e2421ef084f3865faaf35d",
"assets/assets/Docker/quizzes/Docker_Registry_and_Distribution.json": "e9e428fdaa9aa389ecfe32b07b9a79ce",
"assets/assets/Docker/quizzes/Docker_Security.json": "a14638c93572741c7a84a868c31a488e",
"assets/assets/Docker/quizzes/Docker_Storage_and_Volumes.json": "2dc7e23836553074d4798fd908621021",
"assets/assets/explore.json": "76c0c9f252c6e278bfe6ac4d9c953d78",
"assets/assets/faqs.json": "36105de58a4b1099557a83c2698c7bdf",
"assets/assets/files.js": "54de6aa1b2916ad825d2ddf7fed2e441",
"assets/assets/Git/quizzes/git_advanced.json": "95fdc2725f040e88f8b784c1c80ac73e",
"assets/assets/Git/quizzes/git_branches.json": "01b689b3bd44e56fd9aa4ec7b1663160",
"assets/assets/Git/quizzes/git_collaboration.json": "124bf35106851aa7872c095ed321abe7",
"assets/assets/Git/quizzes/git_commands.json": "00a605b0f554de3641141c349c49eea8",
"assets/assets/Git/quizzes/git_deployment.json": "a664697ecaa772e1c0b13bf3a9f73f50",
"assets/assets/Git/quizzes/git_intro.json": "906094e0bf6d95ef0b449eed18de27cc",
"assets/assets/Git/quizzes/git_merging.json": "567d949de2488224f021911149a4e08c",
"assets/assets/Git/quizzes/git_optimization.json": "597541bf730f5ee17f4e541b0989443f",
"assets/assets/Git/quizzes/git_rebasing.json": "873f8164ee51455f4c0e6abae6e87b33",
"assets/assets/Git/quizzes/git_repositories.json": "6c057b9b058431df1178dc218fc1ad0f",
"assets/assets/Git/quizzes/git_security.json": "718bd1968236f043fbcd5fa6a866e414",
"assets/assets/Git/quizzes/git_undoing_changes.json": "20c4cafc0cbd65b54e4c0241875f8f9a",
"assets/assets/HTML/quizzes/html_apis.json": "c45bd750ef0e4124303f934eb2ed0093",
"assets/assets/HTML/quizzes/html_forms.json": "ffb21c8b2eadaa0be642746df3ae51a2",
"assets/assets/HTML/quizzes/html_intro.json": "5da6997ee043011fcfd9d210e2de2ef0",
"assets/assets/HTML/quizzes/html_media.json": "042e415e5e2ea2dcc0eca97f3bdfeb02",
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
"assets/assets/Javascript/quizzes/javascript_async.json": "13869f685860d00614f5a8dbb4bca2aa",
"assets/assets/Javascript/quizzes/javascript_bom.json": "ef12421f65c91ad7ed0b8ee055666153",
"assets/assets/Javascript/quizzes/javascript_intro.json": "fd2f91b1c96c0b8fea4209cc5fd73879",
"assets/assets/Javascript/quizzes/javascript_web_apis.json": "3830c442a541c88c32a5122fd5dec139",
"assets/assets/Keras/quizzes/Advanced_Keras_Topics.json": "bb82f63bb82f82bccc1f10f064c819b1",
"assets/assets/Keras/quizzes/Convolutional_Neural_Networks.json": "6faabc1fe3d34f3bb19f499d5df80d84",
"assets/assets/Keras/quizzes/Generative_Adversarial_Networks.json": "132d9a6e979fccd32d7c84c047030eee",
"assets/assets/Keras/quizzes/Introduction_to_Keras.json": "261a0dc3702400d0fc2cb266ea642abd",
"assets/assets/Keras/quizzes/Neural_Networks_with_Keras.json": "77c9d553b977a9eceba668f525fe53a8",
"assets/assets/Keras/quizzes/Recurrent_Neural_Networks.json": "0128faf510fa4b1962915794f9f32a3f",
"assets/assets/Keras/quizzes/Transfer_Learning.json": "ed8448ad9acdbda68dbe6d0b0a71069a",
"assets/assets/Kubernetes/quizzes/Advanced_Kubernetes_Concepts.json": "5e01c76f4532cf2e84a1f0e1b89424d0",
"assets/assets/Kubernetes/quizzes/CI_CD_with_Kubernetes.json": "ec68de50ff44cf04333dc7f86b89777b",
"assets/assets/Kubernetes/quizzes/Cluster_Management.json": "cf140db938a76fac723fcfef91e53108",
"assets/assets/Kubernetes/quizzes/Configuration_and_Security.json": "de16e3861f5e80e5d0fd81cac3d6ee5c",
"assets/assets/Kubernetes/quizzes/Deployments_and_StatefulSets.json": "1af0b8303ad183363da73a3fa7faf3eb",
"assets/assets/Kubernetes/quizzes/Kubernetes_Architecture.json": "0b84af47b00a65476b8cb37956e7dcc4",
"assets/assets/Kubernetes/quizzes/Monitoring_and_Logging.json": "4ed0930802d82c4ce813afa6de406473",
"assets/assets/Kubernetes/quizzes/Pod_Lifecycle_and_Design.json": "bf5fee97174732d809da1ae22f5d5866",
"assets/assets/Kubernetes/quizzes/Resource_Management.json": "d1f2d55ec535f67f013f7ed7c142a7c4",
"assets/assets/Kubernetes/quizzes/Scaling_and_Performance.json": "71cf59ed27491336dea78b330b1b05f7",
"assets/assets/Kubernetes/quizzes/Services_and_Networking.json": "1e9b57567e722e97b40723961929a8d6",
"assets/assets/Kubernetes/quizzes/Storage_and_Persistence.json": "622c05c1871be21bb006fc6f2bc939f8",
"assets/assets/Linux/quizzes/linux_accessibility.json": "b437c8196ff3fbe5e2a832e58fda0bee",
"assets/assets/Linux/quizzes/linux_advanced.json": "44bc195f7cc490db9fdc6fe2d789121a",
"assets/assets/Linux/quizzes/linux_bash.json": "c597494ade3955999893594a7f88d99d",
"assets/assets/Linux/quizzes/linux_commands.json": "ecadc4b6d121c61a071ec4e2da9b90ec",
"assets/assets/Linux/quizzes/linux_deployment.json": "185d843dc19e21dde08b11ee756cf8a6",
"assets/assets/Linux/quizzes/linux_intro.json": "510f73a5cf4e343067c6ecaaf62e68a2",
"assets/assets/Linux/quizzes/linux_optimization.json": "39394e7a00db3c0f877b8ce53e8fdc44",
"assets/assets/Linux/quizzes/linux_permissions.json": "cdf7c8cb8e9e1d66883c9013f4757487",
"assets/assets/Linux/quizzes/linux_scripts.json": "6850997350d1fe2a6b8be9579e27b38f",
"assets/assets/Linux/quizzes/linux_security.json": "5b4cab628d22ed7ab04580cbd68c520d",
"assets/assets/Linux/quizzes/linux_troubleshooting.json": "d2c9a310c427f7cdd072c26c51aadd16",
"assets/assets/Machine%2520Learning/quizzes/Advanced_Topics_in_ML.json": "9c9e679b9c3ac5515f9404561a16b435",
"assets/assets/Machine%2520Learning/quizzes/Computer_Vision.json": "4208d063d3fca1f0d6c3b3a690afab42",
"assets/assets/Machine%2520Learning/quizzes/Deep_Learning_Foundations.json": "f618ad0757d237af71df6e5b53cd9403",
"assets/assets/Machine%2520Learning/quizzes/Deployment_and_Productionization.json": "9190936a2855de65661ceefb49c79142",
"assets/assets/Machine%2520Learning/quizzes/Dimensionality_Reduction.json": "d4c99d8737e3aaa6089de7e2374b53dd",
"assets/assets/Machine%2520Learning/quizzes/Ethical_Considerations_in_ML.json": "3c85eb3a8579d8cbcae7cfbc4ae5ad7d",
"assets/assets/Machine%2520Learning/quizzes/Feature_Engineering_and_Selection.json": "064fc3be178de777e2129cd130a3d547",
"assets/assets/Machine%2520Learning/quizzes/Machine_Learning_Fundamentals.json": "1984347261dd2cb9a86a66bf58a672b4",
"assets/assets/Machine%2520Learning/quizzes/Model_Evaluation_and_Selection.json": "e23fe4bb52bf8c0a4ed1366454df7885",
"assets/assets/Machine%2520Learning/quizzes/Natural_Language_Processing.json": "e6fb82c1b2e35ce6b322c0441a9b2774",
"assets/assets/Machine%2520Learning/quizzes/Reinforcement_Learning.json": "caf80343f9c2746ee4e8238899fde52d",
"assets/assets/Machine%2520Learning/quizzes/Supervised_Learning.json": "3628c594f08e69cd0dde05ec84862091",
"assets/assets/Machine%2520Learning/quizzes/Time_Series_Analysis.json": "4a960c414c249102c813279268cc29b7",
"assets/assets/Machine%2520Learning/quizzes/Unsupervised_Learning.json": "e436161f31a63c5dfdae3d2e274fb777",
"assets/assets/Matplotlib/quizzes/3D_Plotting.json": "3675fb4f1392209cc6d4e0eb66cda09b",
"assets/assets/Matplotlib/quizzes/Advanced_Plotting.json": "5faba8442d48c077069fa8896d636712",
"assets/assets/Matplotlib/quizzes/Advanced_Topics.json": "7ad1ab41196a0f0cd54b5aed9e2c4d69",
"assets/assets/Matplotlib/quizzes/Animations_and_Interactivity.json": "37c9916d4b09881b409948a0fab9e132",
"assets/assets/Matplotlib/quizzes/Creating_Plots.json": "86b9599728f2e24593d3d84fcfc41e4e",
"assets/assets/Matplotlib/quizzes/Customizing_Plots.json": "536ffb72586bf045c842b93eb41bad13",
"assets/assets/Matplotlib/quizzes/Introduction_to_Matplotlib.json": "b6fbc80fb394da42b514f77bfddf1345",
"assets/assets/Matplotlib/quizzes/Plotting_Data.json": "e169b38496758c6e85b01d76e905b533",
"assets/assets/Matplotlib/quizzes/Subplots_and_Figures.json": "96858821c74c8a039aea007593fce767",
"assets/assets/mentors.json": "f1a14c41eb74b267251802ecafb62a85",
"assets/assets/ML%2520OPS/quizzes/Dimensionality_Reduction.json": "ce8dfe8f13edf55175aae212bb8bfbf5",
"assets/assets/ML%2520OPS/quizzes/Feature_Engineering_and_Selection.json": "69285cf4cbe5b1163bcb50a57ab740a0",
"assets/assets/ML%2520OPS/quizzes/Model_Deployment.json": "9cc99bd88f8af4baa34532d1b5530982",
"assets/assets/ML%2520OPS/quizzes/Model_Evaluation_and_Selection.json": "099220b0ffa2738ed4e751f47e7b0fbc",
"assets/assets/ML%2520OPS/quizzes/Model_Explainability.json": "9d42592d68e7ec60063652ed96c9e832",
"assets/assets/ML%2520OPS/quizzes/Model_Interpretability.json": "3487ce367d7dd578412f1f80cc8ab624",
"assets/assets/ML%2520OPS/quizzes/Model_Monitoring.json": "bfba773250fe24e3b70ea6724eb49d97",
"assets/assets/ML%2520OPS/quizzes/Model_Validation.json": "a343452821026403a1057b43c89d2f19",
"assets/assets/NodeJs/quizzes/node_advanced.json": "bc87edbcf2f5c7615c4127eabb45c8c4",
"assets/assets/NodeJs/quizzes/node_apis.json": "10f5379130ca687fff7a654cfafa5f52",
"assets/assets/NodeJs/quizzes/node_architecture.json": "eca268cb9a65aeee27c792c6c1f4893d",
"assets/assets/NodeJs/quizzes/node_cloud.json": "a4338b5fb2c893f3c89d4ba432ddade9",
"assets/assets/NodeJs/quizzes/node_deployment.json": "7f53e99bb9617760ec67e00388b92923",
"assets/assets/NodeJs/quizzes/node_express.json": "bc5c39bae7ad4b0f760c64ca10c1f098",
"assets/assets/NodeJs/quizzes/node_intro.json": "2df9ad70618b6e4fb475995276a9ba90",
"assets/assets/NodeJs/quizzes/node_mongodb.json": "1d9f88392171cdc7d7953363ff379798",
"assets/assets/NodeJs/quizzes/node_performance.json": "2f0d37d7e3094a70dc3d31820f65b1af",
"assets/assets/NodeJs/quizzes/node_security.json": "3c6f914730ba0b573631be72e6e24ea1",
"assets/assets/NodeJs/quizzes/node_testing.json": "60beb262f4359ea5206fdee4fe135317",
"assets/assets/Numpy/quizzes/Advanced_Topics.json": "58feacb81e7d03c678691c8fcdad188a",
"assets/assets/Numpy/quizzes/Array_Indexing_and_Slicing.json": "416b30b27f81d7ad90e0b92aa2bbab01",
"assets/assets/Numpy/quizzes/Array_Manipulation.json": "cd56bea9d4d773c90f2b54f5233ffc91",
"assets/assets/Numpy/quizzes/Basic_Array_Operations.json": "eb662f20d494374ec417ed9f91c0bf47",
"assets/assets/Numpy/quizzes/Broadcasting.json": "2e311c888a6a59e1c14623b7b7911847",
"assets/assets/Numpy/quizzes/Creating_NumPy_Arrays.json": "a9841318b0d17012650948f279ed33dc",
"assets/assets/Numpy/quizzes/Introduction_to_NumPy.json": "08ecb83c5948dbb7a7aaf6519a737d4b",
"assets/assets/Numpy/quizzes/Mathematical_Functions.json": "893a77f50f15ce1aec8ceea9e1ca76b1",
"assets/assets/Numpy/quizzes/Working_with_Files.json": "9cd4ed8d582b8e580a7d784b8c1598f7",
"assets/assets/Pandas/quizzes/Creating_and_Reading_Data.json": "872ff421c42e6b369f74a9a70c814716",
"assets/assets/Pandas/quizzes/Data_Aggregation_and_Grouping.json": "19e6ee0953671524659e09a6364d5af2",
"assets/assets/Pandas/quizzes/Data_Cleaning.json": "0b4cfeab0160216a70143a6d5fe730b0",
"assets/assets/Pandas/quizzes/Data_Exploration.json": "d1520c43c2426fd9bb21b91770c7069d",
"assets/assets/Pandas/quizzes/Data_Manipulation.json": "f530bc54e05eadb29ed70659b23dfe78",
"assets/assets/Pandas/quizzes/Data_Visualization.json": "b2ab1e7f0c12e93f38b42392e02727bc",
"assets/assets/Pandas/quizzes/Introduction_to_Pandas.json": "b4ecc782d6df54a22b9fc85aacf266b8",
"assets/assets/Pandas/quizzes/Merging_and_Joining_Data.json": "e39dc076e65790eaeea7c33576823bda",
"assets/assets/Pandas/quizzes/Time_Series_Data.json": "e3e682d449eb4b85c869f8489a9bd263",
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
"assets/assets/Power%2520BI/quizzes/Advanced_Power_BI_Topics.json": "ff28a7f573c7f9e9acb7bcc3f02cfec8",
"assets/assets/Power%2520BI/quizzes/Data_Integration_and_Connections.json": "399b7cf2835cd9fedc2773298942f913",
"assets/assets/Power%2520BI/quizzes/Data_Modeling_and_Design.json": "b11d74e23fe0542de3f697ce57f29895",
"assets/assets/Power%2520BI/quizzes/Data_Transformations_and_Cleaning.json": "14503d6eebb7e1c01c2ab7c495d0aec0",
"assets/assets/Power%2520BI/quizzes/Data_Visualization.json": "35db6e3732b5f856f0e6ae71c1b4656e",
"assets/assets/Power%2520BI/quizzes/Introduction_to_Power_BI.json": "e7918fe9ae65b0f22d9b9b02f614f686",
"assets/assets/Power%2520BI/quizzes/Reporting_and_Dashboarding.json": "e738bb59c615047700c478df82de33e1",
"assets/assets/Prompt%2520Engineering/quizzes/Advanced_Prompting_Techniques.json": "2e88f294f8e93d666a45d1da6dc80f68",
"assets/assets/Prompt%2520Engineering/quizzes/Chain_of_Thought_Prompting.json": "0580612c0a45fd8b2c4b103e50c0485c",
"assets/assets/Prompt%2520Engineering/quizzes/Context_and_Instructions.json": "34bc2897fd2307382d11536007d58733",
"assets/assets/Prompt%2520Engineering/quizzes/Ethics_and_Best_Practices.json": "502cf2e3661fc99f8f5860cc6d5672d1",
"assets/assets/Prompt%2520Engineering/quizzes/Few_Shot_Learning.json": "e9dbdc1319d72501f9afa8db0b5f2403",
"assets/assets/Prompt%2520Engineering/quizzes/Fundamentals_of_Prompt_Engineering.json": "d4745807cb591399fcf06a80182077ee",
"assets/assets/Prompt%2520Engineering/quizzes/Output_Formatting_and_Control.json": "28f66c4949d6e241ef735f75cd5fefae",
"assets/assets/Prompt%2520Engineering/quizzes/Prompt_Design_Patterns.json": "5892584c007d6296473af4e7f4221684",
"assets/assets/Prompt%2520Engineering/quizzes/Prompt_Testing_and_Iteration.json": "e8b4320b4a59d13dbf2174420451813c",
"assets/assets/Prompt%2520Engineering/quizzes/System_and_User_Roles.json": "598ea0aea6dc44229aab9d4196111798",
"assets/assets/PySpark/quizzes/Advanced_Topics.json": "1599d508d25f2870e910f4e9789254de",
"assets/assets/PySpark/quizzes/Data_Analysis.json": "4299004a4812f10f8c94bf1a95806073",
"assets/assets/PySpark/quizzes/Data_Ingestion_and_Loading.json": "b13a8cc4e759f5d03995561e22f3c03c",
"assets/assets/PySpark/quizzes/Data_Transformation.json": "ffd518443b0f0a2f5121bddf6928bf97",
"assets/assets/PySpark/quizzes/Deep_Learning_with_PySpark.json": "3e9899cca0870ba588553fe7d42acdc3",
"assets/assets/PySpark/quizzes/Graph_Analytics_with_PySpark.json": "aa71b59eb53d545d55a0d459e9ad80ff",
"assets/assets/PySpark/quizzes/Introduction_to_PySpark.json": "4e37cd31f181e690834ce527ed51866d",
"assets/assets/PySpark/quizzes/Machine_Learning_with_PySpark.json": "d551fdb0dada5a7d35834c34024e6077",
"assets/assets/Python%2520Programming/quizzes/advanced.json": "5350a04d5b8732ce8c44bcc9923db529",
"assets/assets/Python%2520Programming/quizzes/applications.json": "a834dcc1aa78f68610c7bc930d464d7f",
"assets/assets/Python%2520Programming/quizzes/control_flow.json": "f6080c708fcfa57a24e11e66d8a6b319",
"assets/assets/Python%2520Programming/quizzes/data_structures.json": "a96ac6145f8d3cfaf48e582690cab15a",
"assets/assets/Python%2520Programming/quizzes/error_handling.json": "cfd783d06707d0922580f05113576c0b",
"assets/assets/Python%2520Programming/quizzes/files.json": "0eee6df248869c738e119edd221821bd",
"assets/assets/Python%2520Programming/quizzes/functions.json": "fd4cbb8e709500c387e7f85113a26c25",
"assets/assets/Python%2520Programming/quizzes/intro.json": "883bc27b606284a669da2dfc57fb59b9",
"assets/assets/Python%2520Programming/quizzes/modules.json": "ad16024e472a08827f77bef118941932",
"assets/assets/Python%2520Programming/quizzes/oops.json": "8d08d6a35f8d4e9bca263d3aad44fa86",
"assets/assets/PyTorch/quizzes/Advanced_Topics.json": "a658895f1436768419e54d5750ebaccc",
"assets/assets/PyTorch/quizzes/Introduction_to_PyTorch.json": "324241bfff96a9a0cfddcdeb6a5b43a0",
"assets/assets/PyTorch/quizzes/Neural_Networks.json": "b364c78cd2d454e289c7438c059ca5bf",
"assets/assets/PyTorch/quizzes/PyTorch_for_Deep_Learning.json": "e79eb392b85e5315b9efd6705dd880c5",
"assets/assets/PyTorch/quizzes/Tensors_and_Autograd.json": "00584412c4095243d350eecf6bd4abe9",
"assets/assets/PyTorch/quizzes/Training_and_Optimization.json": "c483f9b9365408b77f61df5ad8024f44",
"assets/assets/PyTorch/quizzes/Transfer_Learning.json": "d5ca1e0519a28e1c6ad6361af43513a4",
"assets/assets/ReactJs/quizzes/react_accessibility.json": "7e69d5ba264dd5d269925fd7bfec6387",
"assets/assets/ReactJs/quizzes/react_advanced.json": "72b68af955104a65596b124bcc86cae7",
"assets/assets/ReactJs/quizzes/react_apis.json": "83ff65accb15da1eaa946be952d5babd",
"assets/assets/ReactJs/quizzes/react_components.json": "c18588d4147036aa675a25c24ed7c873",
"assets/assets/ReactJs/quizzes/react_deployment.json": "d907a1ce6953653598adcf1b3fafc6b8",
"assets/assets/ReactJs/quizzes/react_hooks.json": "03521ebe899aead68645d8b28ea3f73d",
"assets/assets/ReactJs/quizzes/react_intro.json": "3c81d57afa9ab3fb10e3bdb9c6cbe17f",
"assets/assets/ReactJs/quizzes/react_optimization.json": "d96e4479bd0016c954417ff57f0f6d6c",
"assets/assets/ReactJs/quizzes/react_routing.json": "53d1099cd45465720b8222df8f94ebe6",
"assets/assets/ReactJs/quizzes/react_security.json": "18d78e07e6c0b5b9d523b0a2dd70fb97",
"assets/assets/ReactJs/quizzes/react_state_management.json": "53c35e7347e12a437f9d82ec2b095d8d",
"assets/assets/Reinforcement%2520Learning/Actor_Critic_Methods.json": "bc4326f79fdf9968f179e4ff1328850a",
"assets/assets/Reinforcement%2520Learning/Deep_Q_Networks.json": "c579befee1a196218c0d0670b1160454",
"assets/assets/Reinforcement%2520Learning/Introduction_to_Reinforcement_Learning.json": "811a5b4654c01313316805834719a978",
"assets/assets/Reinforcement%2520Learning/Markov_Decision_Process.json": "80a869e088281a14e1d5e00c4294e241",
"assets/assets/Reinforcement%2520Learning/Policy_Gradient_Methods.json": "0f0120f99c52ed93176526a979621cb8",
"assets/assets/Reinforcement%2520Learning/Q-Learning.json": "e63a764ff59fc087635c8953f699755f",
"assets/assets/Reinforcement%2520Learning/Reinforcement_Learning_Algorithms.json": "dd28b438d72f4ad10789eb8a7af482a0",
"assets/assets/SciPy/quizzes/Advanced_Topics.json": "b92794088301c98e165d568b2f02d6a1",
"assets/assets/SciPy/quizzes/Image_Processing.json": "75ff0afafbdd05d87135983e8e9e0d2a",
"assets/assets/SciPy/quizzes/Integration_and_Optimization.json": "5836f371d8f56b2f42551ac0cd2a20f5",
"assets/assets/SciPy/quizzes/Interpolation.json": "72315dd798343296dacaa15240e809f4",
"assets/assets/SciPy/quizzes/Introduction_to_SciPy.json": "ead019dec945f0f76860c0d558b82b0f",
"assets/assets/SciPy/quizzes/Linear_Algebra.json": "9e075f01dab89ceb71d6085425c054e5",
"assets/assets/SciPy/quizzes/Machine_Learning_with_SciPy.json": "570be8b2283286af436ef90b486c5eb5",
"assets/assets/SciPy/quizzes/Signal_Processing.json": "9bca4073b285eed1bd3f6eeaaedc6282",
"assets/assets/SciPy/quizzes/Spatial_Data_Analysis.json": "7ee30de0dc3a26be4a2c649566c72c77",
"assets/assets/SciPy/quizzes/Statistics.json": "75eb47dcb3bb624667ca07cdc174b86f",
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
"assets/assets/Statistics/quizzes/Data_Analysis_and_Interpretation.json": "349343fb27ee40355bd32a7128be3fe4",
"assets/assets/Statistics/quizzes/Descriptive_Statistics.json": "22c4da42c992179698427e217feca024",
"assets/assets/Statistics/quizzes/Hypothesis_Testing.json": "cc3ce533e026e2703633af25d944f0c3",
"assets/assets/Statistics/quizzes/Inferential_Statistics.json": "7acf153d4c33d536e4646ec2948c8e03",
"assets/assets/Statistics/quizzes/Introduction_to_Statistics.json": "4d4c2c99dcb81b18532de51460f3ecdb",
"assets/assets/Statistics/quizzes/Multivariate_Analysis.json": "9f999cfd389eda09c3bedd492606caed",
"assets/assets/Statistics/quizzes/Probability_and_Random_Variables.json": "95c34e0f10c8a61e28601294d7dc14a2",
"assets/assets/Statistics/quizzes/Regression_Analysis.json": "b9beb2232ceb513ae4d6cc0a53d6c885",
"assets/assets/Statistics/quizzes/Statistical_Methods.json": "1e1b0019dc8bd42a53198dcc27dfe17b",
"assets/assets/Statistics/quizzes/Time_Series_Analysis.json": "35b0eb618dd5d7f8e13881a1f5c0df8c",
"assets/assets/student_home/logo.png": "d50db7cacaba6f3fff5c9d13b283d428",
"assets/assets/student_home/qrcode.jpg": "bb15dcae08e75ee837eaa40f51112ad5",
"assets/assets/student_home/sfcmp.png": "62aa2a5c327025b8c04d34c76626f7cc",
"assets/assets/student_home/sf_home_1.png": "e8f726c374db3837ae9cfd0694c6638f",
"assets/assets/student_home/sf_home_2.png": "a13e5bae3fa2eb43a777fe9c6869c537",
"assets/assets/Sudoku/quizzes/Advanced_Techniques.json": "e5d20f427fd36be79bee2faffce15d52",
"assets/assets/Sudoku/quizzes/Basic_Solving_Techniques.json": "c82ae1560be289380375a706bf38f73c",
"assets/assets/Sudoku/quizzes/Competition_Strategies.json": "b31aad4129ab2da9da43e3ee9c499f0b",
"assets/assets/Sudoku/quizzes/Grid_Structure.json": "a175b7e79545f1c11e5978d17fcf4ac5",
"assets/assets/Sudoku/quizzes/Intermediate_Strategies.json": "299165d31ee665f80a8ef4ca90f1b0a8",
"assets/assets/Sudoku/quizzes/Logic_and_Reasoning.json": "ff95a6a2f9a4a501fd04564065069f02",
"assets/assets/Sudoku/quizzes/Number_Placement_Rules.json": "18a1774c1f0830f15386d64730368e02",
"assets/assets/Sudoku/quizzes/Pattern_Recognition.json": "30745d9bbb4af281b194b8d3983acdb8",
"assets/assets/Sudoku/quizzes/Puzzle_Creation.json": "0cd5507da01101c37b6a237cba5b14b2",
"assets/assets/Sudoku/quizzes/Speed_Solving_Methods.json": "2cdad14b410c8ef4a74ca803dba3d398",
"assets/assets/Sudoku/quizzes/Sudoku_Basics.json": "95d88ae42c6620f657f4ae8ed5f5cb98",
"assets/assets/Sudoku/quizzes/Variant_Sudoku_Types.json": "9f73a44e8a3a1c587d06391c36ebafc6",
"assets/assets/Supervised%2520Learning/quizzes/Decision_Trees.json": "02626bf05672c471c474ef457a9286ca",
"assets/assets/Supervised%2520Learning/quizzes/K_Nearest_Neighbors.json": "9d3a11653bbed58285138278930fc0b1",
"assets/assets/Supervised%2520Learning/quizzes/Linear_Regression.json": "4e407792dc0e41da69d8afef5fdcba7f",
"assets/assets/Supervised%2520Learning/quizzes/Logistic_Regression.json": "b66bd38cf7e709c2584705913f9ebd52",
"assets/assets/Supervised%2520Learning/quizzes/Model_Evaluation.json": "39a67a6c2cdf4c2dcfca4c7e5bdac99e",
"assets/assets/Supervised%2520Learning/quizzes/Random_Forests.json": "0388bf4d72ec7b2725465f42bb8fd9b7",
"assets/assets/Supervised%2520Learning/quizzes/Support_Vector_Machines.json": "2c0d87262504a174c8811aecf279d352",
"assets/assets/Supervised%2520Learning/quizzes/Time_Series_Forecasting.json": "2c5f834d78d459ceca8633296c68b938",
"assets/assets/Tableau/quizzes/Advanced_Tableau_Topics.json": "ccf7abcd76e65c34675d4a207ed8142c",
"assets/assets/Tableau/quizzes/Dashboard_Creation.json": "03db869bfa54db52c9fb0c531f734490",
"assets/assets/Tableau/quizzes/Data_Exploration.json": "89001a8afc69338161db9ec8964b2d6d",
"assets/assets/Tableau/quizzes/Data_Modeling.json": "0223be8c66503074dc0282761681857f",
"assets/assets/Tableau/quizzes/Data_Visualization_Basics.json": "8ffaf6044b06c295a90a6b8e9b51d004",
"assets/assets/Tableau/quizzes/Interactive_Visualizations.json": "39f9b09db9d7e2282bdf9df3ea0e8f12",
"assets/assets/Tableau/quizzes/Introduction_to_Tableau.json": "667e3f23066ad66967935e7f1574391f",
"assets/assets/TensorFlow/quizzes/Advanced_Topics.json": "68b3c0ce30c88c52fd8f548539dcb581",
"assets/assets/TensorFlow/quizzes/Convolutional_Neural_Networks.json": "4d41f18897f8b8ae43dad367609ddacf",
"assets/assets/TensorFlow/quizzes/Generative_Adversarial_Networks.json": "a5bb3c23b87aec81712bbd6318b43534",
"assets/assets/TensorFlow/quizzes/Introduction_to_TensorFlow.json": "2e74589a986b992aeba5fc53154ecf16",
"assets/assets/TensorFlow/quizzes/Neural_Networks_with_TensorFlow.json": "c8ef622272aae9c3471898cb6e5049e4",
"assets/assets/TensorFlow/quizzes/Recurrent_Neural_Networks.json": "166827113f824d146c13ecddea26143c",
"assets/assets/TensorFlow/quizzes/TensorFlow_Basics.json": "8e862e88c403941602be5b27c07ddb52",
"assets/assets/TensorFlow/quizzes/Transfer_Learning.json": "6593241fee54e5193868f9a4a048b785",
"assets/assets/universities.json": "d15718fa20a6934dd22346bc7896d7dd",
"assets/assets/Unsupervised%2520Learning/quizzes/Association_Rules.json": "214e447fbe755863b3ec952714de03aa",
"assets/assets/Unsupervised%2520Learning/quizzes/Clustering.json": "8a0f8ec50a6f89c34b6c77eb50f7829e",
"assets/assets/Unsupervised%2520Learning/quizzes/Dimensionality_Reduction.json": "ad7588ab54fcdb0f3dd92f7057e7b52a",
"assets/assets/Unsupervised%2520Learning/quizzes/K_Means_Clustering.json": "b9b9ccabfbb179098e141d7431890015",
"assets/assets/Unsupervised%2520Learning/quizzes/Linear_Discriminant_Analysis.json": "85eb1b20b35ae32844a07290d80d40ad",
"assets/assets/Unsupervised%2520Learning/quizzes/Pricipal_Component_Analysis.json": "d258da9c1d84556e882b7fb702107ffc",
"assets/FontManifest.json": "5a32d4310a6f5d9a6b651e75ba0d7372",
"assets/fonts/MaterialIcons-Regular.otf": "8521f09e0617c2be771c2857251ef91a",
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
"flutter_bootstrap.js": "d2660e69ae5bbe6c32642dd9ca41c4eb",
"icons/Icon-192.png": "9b9147761b789428e0bc90a976b1fcb5",
"icons/Icon-512.png": "d50db7cacaba6f3fff5c9d13b283d428",
"icons/Icon-maskable-192.png": "9b9147761b789428e0bc90a976b1fcb5",
"icons/Icon-maskable-512.png": "d50db7cacaba6f3fff5c9d13b283d428",
"index.html": "ec92ad47dce089c17f6c4203cb097d14",
"/": "ec92ad47dce089c17f6c4203cb097d14",
"main.dart.js": "fa48ced7717bf74e1216f3fa94c56f71",
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
