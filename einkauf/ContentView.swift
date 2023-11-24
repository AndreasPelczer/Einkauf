import SwiftUI

struct ContentView: View {
    @State private var apfelAnzahl: Int = 0
    @State private var bananeAnzahl: Int = 0
    @State private var orangeAnzahl: Int = 0
    @State private var bargeldEingabe: String = ""

    let apfelPreis: Double = 0.50
    let bananePreis: Double = 0.30
    let orangePreis: Double = 0.60

    var body: some View {
        VStack {
            Text("Willkommen in unserem Früchteshop!")

            HStack {
                VStack {
                    Text("🍏")
                    Button(action: {
                        self.erhoeheAnzahl(fuer: "Apfel")
                    }) {
                        Image(systemName: "plus.circle")
                    }
                    Button(action: {
                        self.verringereAnzahl(fuer: "Apfel")
                    }) {
                        Image(systemName: "minus.circle")
                    }
                    Text("\(apfelAnzahl) mal gekauft")
                    Text("Gesamtpreis: \(String(format: "%.2f", berechneGesamtpreis(fuer: "Apfel")))💰")
                }

                VStack {
                    Text("🍌")
                    Button(action: {
                        self.erhoeheAnzahl(fuer: "Banane")
                    }) {
                        Image(systemName: "plus.circle")
                    }
                    Button(action: {
                        self.verringereAnzahl(fuer: "Banane")
                    }) {
                        Image(systemName: "minus.circle")
                    }
                    Text("\(bananeAnzahl) mal gekauft")
                    Text("Gesamtpreis: \(String(format: "%.2f", berechneGesamtpreis(fuer: "Banane")))💰")
                }

                VStack {
                    Text("🍊")
                    Button(action: {
                        self.erhoeheAnzahl(fuer: "Orange")
                    }) {
                        Image(systemName: "plus.circle")
                    }
                    Button(action: {
                        self.verringereAnzahl(fuer: "Orange")
                    }) {
                        Image(systemName: "minus.circle")
                    }
                    Text("\(orangeAnzahl) mal gekauft")
                    Text("Gesamtpreis: \(String(format: "%.2f", berechneGesamtpreis(fuer: "Orange")))💰")
                }
            }

            TextField("Bargeldbetrag eingeben", text: $bargeldEingabe)
                .keyboardType(.decimalPad)
                .padding()
            
            Button("Bezahlen") {
                self.berechneWechselgeld()
            }

            Text("Gesamtsumme: \(String(format: "%.2f", berechneGesamtsumme()))💰")
                .padding(.top, 20)
            Text("Wechselgeld: \(self.berechneWechselgeld())💰")
        }
        .padding()
    }

    func erhoeheAnzahl(fuer frucht: String) {
        switch frucht {
        case "Apfel":
            apfelAnzahl += 1
        case "Banane":
            bananeAnzahl += 1
        case "Orange":
            orangeAnzahl += 1
        default:
            break
        }
    }

    func verringereAnzahl(fuer frucht: String) {
        switch frucht {
        case "Apfel":
            if apfelAnzahl > 0 {
                apfelAnzahl -= 1
            }
        case "Banane":
            if bananeAnzahl > 0 {
                bananeAnzahl -= 1
            }
        case "Orange":
            if orangeAnzahl > 0 {
                orangeAnzahl -= 1
            }
        default:
            break
        }
    }

    func berechneGesamtpreis(fuer frucht: String) -> Double {
        switch frucht {
        case "Apfel":
            return Double(apfelAnzahl) * apfelPreis
        case "Banane":
            return Double(bananeAnzahl) * bananePreis
        case "Orange":
            return Double(orangeAnzahl) * orangePreis
        default:
            return 0.0
        }
    }

    func berechneGesamtsumme() -> Double {
        return berechneGesamtpreis(fuer: "Apfel") + berechneGesamtpreis(fuer: "Banane") + berechneGesamtpreis(fuer: "Orange")
    }

    func berechneWechselgeld() -> String {
        guard let bargeldBetrag = Double(bargeldEingabe) else {
            return "Ungültiger Betrag"
        }

        let gesamtBetrag = berechneGesamtsumme()
        let wechselgeld = bargeldBetrag - gesamtBetrag

        if wechselgeld >= 0 {
            return String(format: "%.2f", wechselgeld)
        } else {
            return "Zu wenig Geld bezahlt"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
