App = {
  web3Provider: null,
  contracts: {},

  init: function() {
    // Load pets.
    $.getJSON('../nodes.json', function(data) {
      var petsRow = $('#petsRow');
      var petTemplate = $('#petTemplate');

      for (i = 0; i < data.length; i ++) {
        petTemplate.find('.panel-title').text(data[i].name);
        petsRow.append(petTemplate.html());
      }
    });

    return App.initWeb3();
  },


    initWeb3: function() {
        // Is there an injected web3 instance?
        if (typeof web3 !== 'undefined') {
            App.web3Provider = web3.currentProvider;
        } else {
            // If no injected web3 instance is detected, fall back to Ganache
            App.web3Provider = new Web3.providers.HttpProvider('http://localhost:22000');
        }
        web3 = new Web3(App.web3Provider);

        return App.initContract();
    },


  initContract: function() {

      $.getJSON('SimpleStorage.json', function(ownerProfileMappingArtifact) {
          App.contracts.SimpleStorage = TruffleContract(ownerProfileMappingArtifact);
          App.contracts.SimpleStorage.setProvider(App.web3Provider);
      });

      $.getJSON('SimpleStoragePublico.json', function(ownerProfileMappingArtifact) {
          App.contracts.SimpleStoragePublico = TruffleContract(ownerProfileMappingArtifact);
          App.contracts.SimpleStoragePublico.setProvider(App.web3Provider);
      });


      return App.bindEvents();
  },


    testPrivateStore : function() {
        App.contracts.SimpleStorage.deployed().then(function(instance) {
            console.log("1");
            console.log(instance);
            console.log("2");

            return instance.get();

        }).then(function(name) {
            console.log(name);


        }).catch(function(err) {
            console.log(err.message);
        });
    },


    testPublicStore : function() {
        App.contracts.SimpleStoragePublico.deployed().then(function(instance) {
            console.log("1");
            console.log(instance);
            console.log("2");

            return instance.get();

        }).then(function(name) {
            console.log(name);


        }).catch(function(err) {
            console.log(err.message);
        });
    },


  bindEvents: function() {
    $(document).on('click', '.btn-adopt', App.handleAdopt);
  },

  markAdopted: function(adopters, account) {
    /*
     * Replace me...
     */
  },

  handleAdopt: function(event) {
    event.preventDefault();

    var petId = parseInt($(event.target).data('id'));

    /*
     * Replace me...
     */
  }

};

$(function() {
  $(window).load(function() {
    App.init();
  });
});
