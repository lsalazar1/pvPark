const axios = require('axios');
const assert=require('assert');

const baseURI = "https://blooming-mountain-10766.herokuapp.com/";

const successCode = 200;

const config = {
    headers: {
        'Content-Type': 'application/json'
    }
}

const registerData = [
    {
        "username": "orange_guy10",
        "password": "ackabacka95",
        "email": "dtrump@pvamu.edu",
        "name": "Donald Trump",
        "expected": 200
    },
    {
        "username": "uncle_joe2005",
        "password": "ackabacka95",
        "email": "jbiden@pvamu.edu",
        "name": "Joe Biden",
        "expected": 200
    }
]

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

//  GET api/srcollins
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

// GET api/newscience
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

// GET api/businessag
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

// GET api/msc
axios.get(baseURI+"api/msc")
    .then(res => {
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

// POST api/users
for (let i = 0; i < registerData.length; i++) {

    let {username, name, password, email, expected} = registerData[i];
    let num_test_passing = 0;

    let body = JSON.stringify({username, name, password, email});

    axios.post(baseURI + 'api/users', body, config)
        .then(res => {
            let responseStatus = res.status;

            assert.deepEqual(responseStatus, expected, `Expected ${expected} but received ${responseStatus}`);
            num_test_passing += 1;
        })
        .catch(err => {
            console.error(`api/users... ${num_test_passing} case(s) passed... Failing at [${i}]`);
            exit(1);
        })
}