const axios = require('axios');
const assert=require('assert');

const PORT = process.env.PORT || 5000;
const baseURI = `http://localhost:${PORT}/`;

const successCode = 200;

// Testing if backend is connected
axios.get(baseURI)
    .then(res => {
        assert.deepEqual(res.status, successCode, "Not connected right");
        console.log('Backend is connected...');
    })
    .catch(err => console.error(err.message))

// Testing api/srcollins endpoint
axios.get(baseURI+"api/srcollins")
    .then(res => {
        let lotName = res.data.lotName;
        let responseStatus = res.status;

        assert.deepEqual(lotName, "srcollins", `Expected name to be srcollins but returned ${lotName}`);
        assert.deepEqual(responseStatus, successCode, `Expected a 200 Status Code but returned ${responseStatus}`);

        console.log("api/srcollins works");
    })
    .catch(err => console.error(err.message))

// Testing api/newscience
axios.get(baseURI+"api/newscience")
    .then(res => {
        let lotName = res.data.lotName;
        let responseStatus = res.status;

        assert.deepEqual(lotName, "newscience", `Expected name to be newscience but returned ${lotName}`);
        assert.deepEqual(responseStatus, successCode, `Expected a 200 Status Code but returned ${responseStatus}`);

        console.log("api/newscience works");
    })
    .catch(err => console.error(err.message));

// Testing api/rasp

// Testing api/businessag
