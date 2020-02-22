const axios = require('axios');
const assert=require('assert');

const PORT = process.env.PORT || 5000;
const baseURI = `http://localhost:${PORT}/`;

// Testing if backend is connected
axios.get(baseURI)
    .then(res => {
        assert.deepEqual(res.status, 200, "Not connected right");
        console.log('Backend is connected...');
    })
    .catch(err => console.error(err.message))

// Testing api/srcollins endpoint
axios.get(baseURI+"api/srcollins")
    .then(res => {
        let lotName = res.data.lotName;
        let statusCode = 200;

        assert.deepEqual(lotName, "srcollins", `Expected name to be srcollins but returned ${lotName}`);
        assert.deepEqual(statusCode, 200, `Expected a 200 Status Code but returned ${statusCode}`);
        console.log("api/srcollins works");
    })
    .catch(err => console.error(err.message))

// Testing api/newscience
axios.get(baseURI+"api/newscience")
    .then(res => {
        let lotName = res.data.lotName;
        let statusCode = 200;

        assert.deepEqual(lotName, "newscience", `Expected name to be srcollins but returned ${lotName}`);
        assert.deepEqual(statusCode, 200, `Expected a 200 Status Code but returned ${statusCode}`);
        console.log("api/newscience works");
    })
    .catch(err => console.error(err.message));

// Testing api/rasp

// Testing api/businessag
