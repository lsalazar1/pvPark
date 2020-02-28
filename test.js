const axios = require('axios');
const assert=require('assert');

const baseURI = "https://blooming-mountain-10766.herokuapp.com/";

const successCode = 200;

// Testing if backend is connected
axios.get(baseURI)
    .then(res => {
        assert.deepEqual(res.status, successCode, "Not connected right");
        console.log('Backend is connected...');
    })
    .catch(err => {
        console.error(err.message);
        exit(1);
    });

// Testing GET api/srcollins endpoint
axios.get(baseURI+"api/srcollins")
    .then(res => {
        let lotName = res.data.lotName;
        let responseStatus = res.status;

        assert.deepEqual(lotName, "srcollins", `Expected name to be srcollins but returned ${lotName}`);
        assert.deepEqual(responseStatus, successCode, `Expected a 200 Status Code but returned ${responseStatus}`);

        console.log("api/srcollins works...");
    })
    .catch(err => {
        console.error(err.message);
        exit(1);
    });

// Testing GET api/newscience
axios.get(baseURI+"api/newscience")
    .then(res => {
        let lotName = res.data.lotName;
        let responseStatus = res.status;

        assert.deepEqual(lotName, "newscience", `Expected name to be newscience but returned ${lotName}`);
        assert.deepEqual(responseStatus, successCode, `Expected a 200 Status Code but returned ${responseStatus}`);

        console.log("api/newscience works...");
    })
    .catch(err => {
        console.error(err.message);
        exit(1);
    });

// Testing api/businessag
axios.get(baseURI+"api/businessag")
    .then(res => {
        let lotName = res.data.lotName;
        let responseStatus = res.status;

        assert.deepEqual(lotName, "businessag", `Expected name to be businessag but returned ${lotName}`);
        assert.deepEqual(responseStatus, successCode, `Expected a 200 Status Code but returned ${responseStatus}`);

        console.log("api/businessag works");
    })
    .catch(err => {
        console.error(err.message);
        exit(1);
    });

axios.get(baseURI+"api/msc")
    .then( res => {
        let lotName = res.data.lotName;
        let responseStatus = res.status;

        assert.deepEqual(lotName, 'memorial student center', `Expected name to be msc but returned ${lotName}`);
        assert.deepEqual(responseStatus, successCode, `Expected a 200 Status Code but returned ${responseStatus}`);

        console.log("api/msc works...");
    })
    .catch(err => {
        console.error(err.message);
        exit(1);
    });
