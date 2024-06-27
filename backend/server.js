const express = require("express");
const multer = require("multer");
const path = require('path');
const child_process = require('child_process');
//i 
const app = express();

app.use(express.urlencoded({ extended: false }));
app.use('/uploads', express.static(path.join(__dirname, 'uploads')));

app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, "./index.html"));
});

const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        const uploadPath = "./uploads";
        cb(null, uploadPath);
    },
    filename: (req, file, cb) => {
        cb(null, `${Date.now()}-${file.originalname}`);
    }
});

const upload = multer({ storage });

app.post('/upload', upload.single("image"), (req, res) => {
    console.log(req.file);
    console.log(req.body);

    const inputPath = path.join(__dirname, 'uploads', req.file.filename);
    const outputPath = path.join(__dirname, 'uploads', `processed-${req.file.filename}`);

    const pythonProcess = child_process.spawn('python', [
        path.join(__dirname, '..\\work_board\\main.py'),
        inputPath,
        outputPath,
        'W3qPqcMolWonRsfEjphV'  // Pass the API key as an argument
    ]);

    pythonProcess.stdout.on('data', (data) => {
        console.log(`stdout: ${data}`);
    });

    pythonProcess.stderr.on('data', (data) => {
        console.error(`stderr: ${data}`);
    });

    pythonProcess.on('close', (code) => {
        if (code === 0) {
            console.log('Image processed successfully');
            res.status(200).sendFile(outputPath); // Send the processed image back to the client
        } else {
            console.error(`Python script exited with code ${code}`);
            res.status(500).send('Image processing failed');
        }
    });
});

app.listen(5000, () => {
    console.log("listening on port 5000");
});
