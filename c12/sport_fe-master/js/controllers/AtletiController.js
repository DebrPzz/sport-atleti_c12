app.controller('AtletiController', ['$scope', 'AtletiService', //'$routeParams',
    function($scope, AtletiService/*, $routeParams*/) {
    var vm = $scope;
    
    vm.item = {};
    vm.items = [];
    
    vm.loadItem = function(response){
        vm.item = response.data && response.data.item || vm.resetItem();
        vm.message = response.data && response.data.message || "";
    };
    
    vm.resetItem = function(){
        return {
            id:null,
            nome:null,
            telefono:null,
            cf:null,
            datanascita: null,
            sesso: null
        };
    };
    
    vm.loadItems = function(response){
        var list = response.data && response.data.items || [];
        vm.items.length = 0;
        angular.forEach(list, function(v,k){
            vm.items.push(v);
        });
        vm.message = response.data && response.data.message || "";
    };

    vm.save = function(item){
        AtletiService.saveItem(item,vm.loadItem);
    };
    
    vm.delete = function(id){
        AtletiService.delItem(id,vm.loadItems);
    };
    
    vm.init = function(){
        //vm.id = $routeParams && $routeParams.id || false;
        if(vm.id){
            AtletiService.getItem(id,vm.loadItem);
        }else{
            AtletiService.getList(vm.loadItems);
        }
    };
    
    vm.init();
}]);