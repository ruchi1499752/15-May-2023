({
    getNumbers : function(component, event, helper) {
        let num = [];
        for(let i=0; i<20; i++){
            //num.push({value : i});
            num.push(i);
        }
        component.set("v.numbers",num);

    }
})