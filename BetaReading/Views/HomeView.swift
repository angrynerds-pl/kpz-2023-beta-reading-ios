import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel = HomeViewModel()
    @State private var showNewView = false

    var body: some View {
//        ZStack(alignment: .leading){
//            Color(red: 67/255, green: 146/255, blue: 138/255).ignoresSafeArea()
        ZStack {
            Color(red: 67/255, green: 146/255, blue: 138/255).ignoresSafeArea()
            VStack {
                
                HStack(
                    alignment: .center,
                    spacing: 60
                ) {
                    
                    Text("Home Page")
//                        .font(
//                            .title
//                                .weight(.bold))
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        
                    
                    Image("AngryReaders")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100)
                        .aspectRatio(contentMode: .fit)
                    
                    
                }
            //}
            
                VStack(alignment: .leading){
                    
                    List{
                        ForEach(viewModel.list){item in
                            Section{
                                Text(item.title)//+"\n"+item.author)
                                    .fontWeight(.bold)
                                Text(item.author)
                                Text(item.content)
                                Button("Open PDF") {
                                    viewModel.fetchPDFURL(for: item.author, title: item.title)
                                }
                            }
                            //.padding()
                            .listRowBackground(Color(red: 217/255, green: 217/255, blue: 217/255))
                            .listRowBackground(
                                RoundedRectangle(cornerRadius: 5)
                            )
                            .listRowSeparator(.hidden)
                            
                        }
                    }
                    .scrollContentBackground(.hidden)
                    Spacer()
                }
                //List(viewModel.list){item in
                    //Text(item.title+"\n"+item.author)
                    //Text(item.author).padding()
                //}.padding()
                
//                HStack( alignment: .center,
//                        spacing: 60){
//                    TabView{
//                        AddText()
//                            .tabItem {
//                                Label("elo", systemImage: "house")
//                        }
//                        TestUIView()
//                            .tabItem {
//                                Label("ja", systemImage: "person")
//                        }
//                    }
                    //Color(red: 217/255, green: 217/255, blue: 217/255)
//                    Image(systemName: "house")
//                        .font(.system(size: 30))
//                        .padding(6)
//
//                    Image(systemName: "book")
//                        .font(.system(size: 30))
//
//
//                    Image(systemName: "message")
//                        .font(.system(size: 30))
//                        .foregroundColor(Color.black)
//
//                    Image(systemName: "person")
//                        .font(.system(size: 30))
//                    }
                   
                       

//                    label:{ Image(systemName: "message")
//                        .font(.system(size: 30))
//                        .foregroundColor(Color.black)
//                    }
                    
                   
                    
              
                        
                       
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
