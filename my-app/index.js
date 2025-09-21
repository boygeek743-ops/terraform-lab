const express = require('express');
const app = express();
const PORT = process.env.PORT || 3000;

app.get('/', (req, res) => {
    res.send('<h1>Hello from my Ubuntu EC2 server! 🚀</h1>');
});

app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});
