import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel = HomeViewModel()

    var body: some View {

        List(viewModel.list){item in
            Text(item.title)

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
