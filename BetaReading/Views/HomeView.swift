import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel = HomeViewModel()

    var body: some View {
        ZStack(alignment: .leading){
            Color(red: 67/255, green: 146/255, blue: 138/255).ignoresSafeArea()
            
            VStack(alignment: .leading){
                
                List{
                    ForEach(viewModel.list){item in
                        VStack{
                            Text(item.title)//+"\n"+item.author)
                            Text(item.author)
                        }
                        
                    }
                    
                   
                }
                
                //List(viewModel.list){item in
                    //Text(item.title+"\n"+item.author)
                    //Text(item.author).padding()
                //}.padding()
            }
            
        }
    }
    init(){
        viewModel.getData()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
