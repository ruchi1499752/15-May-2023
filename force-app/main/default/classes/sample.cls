public class sample {
	public integer a=10;
    public List<Integer>flist;
    public list<Integer>firstlist;
    public List<Integer>getLMN(){
        if(fList==null)
        {
			fList=new Integer[10];
        }
		for(Integer i=0;i<10;i++)
        {
			fList[i]=i+1;
        }
        return fList;
    }

	public PageReference Page1()
    {
        if(firstList==null)
        {
			firstList=new Integer[10];
        }
		for(Integer i=0;i<10;i++)
        {
			firstList[i]=10*(i+1);
        }

        //System.debug('jkkfk');
        return null;
    }
    
        public List<Integer>getABC()
    	{
        /*...........................................
		for(Integer i=0;i<10;i++)
        {
			fList[i]=fList[i]*10;
        }
		system.debug('11111111111getABC'+firstList);
        ............................................*/
        return firstList;
    	}


}