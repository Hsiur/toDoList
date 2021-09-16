//
//  ContentView.swift
//  ToDoList
//
//  Created by Ruslan Ishmukhametov on 09.09.2021.
//

import SwiftUI

struct ContentView: View {
    
    @State var listOfreminders = ["Купи биткоин", "Сходи к врачу", "Не умри", "Четвертое напоминание"]
    @State var groupOfReminders = ["Покупки","Планы на лето","Ремонт","Отпуск"]
    @State private var newRemind = ""
    @State private var newGroupOfRemind = ""
    @State var isOnToggle = false
    @State var currentgroupOfReminders = "Стандартный список"
    
    
    var body: some View {
        ZStack {
            HStack {
                VStack {
                    List {
                        Section(header: Text("Списки напоминаний"))
                        {
                            ForEach(groupOfReminders, id:\.self) { i in Button(action: {currentgroupOfReminders = i
                                isOnToggle = !isOnToggle
                            }, label: {
                                Text(i)
                            })
                            }.onDelete(perform: deleteGroup)
                            
                        }
                        HStack {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(Color.orange)
                            TextField("Новый список напоминаний", text: $newGroupOfRemind).onTapGesture {
                                if newGroupOfRemind != "" {
                                    groupOfReminders.append(newGroupOfRemind)
                                    newGroupOfRemind = ""
                                }
                            }
                        }
                    }
                    Spacer()
                }
                Spacer()
            }
            
            VStack {
            NavigationView {
                List {
                    TextField("Новое напоминание", text: $newRemind).onTapGesture {
                        if newRemind != "" {
                            listOfreminders.append(newRemind)
                        }
                    }
                    
                    ForEach(listOfreminders, id:\.self) { remind in Text(remind)
                    }
                    .onDelete(perform: delete)
                    .onMove(perform: move)
                }
                .navigationTitle(currentgroupOfReminders)
                .navigationBarItems(trailing: EditButton())
            }.offset(x: isOnToggle ? 300: 0)
            .animation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.3))
            
                // Здесь тестируем работу со структурой
            NavigationView {
                List {
                    TextField("Новое напоминание", text: $newRemind).onTapGesture {
                        if newRemind != "" {
                            listOfreminders.append(newRemind)
                        }
                    }
                    Text("hjhj")

                }
                .navigationTitle(currentgroupOfReminders)
                .navigationBarItems(trailing: EditButton())
            }.offset(x: isOnToggle ? 300: 0)
            .animation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.3))
            }
            
            HStack{
                VStack{
                    Button(action: {
                        isOnToggle = !isOnToggle
                    }, label: {
                        Image(systemName: "list.bullet")
                    })
                    .frame(width: 55, height: 55, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .offset(x: isOnToggle ? 300: 0)
                    .animation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.3))
                    Spacer()
                }
                Spacer()
            }
            
        }
    }
    
    func delete(at offsets: IndexSet) {
        listOfreminders.remove(atOffsets: offsets)
    }
    
    func deleteGroup(at offsets: IndexSet) {
        groupOfReminders.remove(atOffsets: offsets)
    }

    
    func move (from source: IndexSet, to destination: Int) {
        listOfreminders.move(fromOffsets: source, toOffset: destination)
    }
}

struct RemindCard: View {
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/).foregroundColor(.gray).padding(.all)
            HStack{
                Image(systemName: "circle")
                Text("Bay a car")
                Spacer()
                Image(systemName: "exclamationmark.circle")
            }.padding(.horizontal)
        }
        
    }
}

// Структура создания напоминаний
struct Category {
    let name: String
    let Content: Reminders
}

struct Reminders {
    let userRemind: String
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
        ContentView()
            .preferredColorScheme(.dark)
    }
}
