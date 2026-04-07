import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import org.kde.kirigami as Kirigami

Item {
    id: page
    width: childrenRect.width
    height: childrenRect.height

    // Plasma KConfig Bindings
    property string cfg_language: "javascript"
    property alias cfg_colorDecl: declField.text
    property alias cfg_colorVar: varField.text
    property alias cfg_colorPunc: puncField.text
    property alias cfg_colorBrack: brackField.text
    property alias cfg_colorProp: propField.text
    property alias cfg_colorNum: numField.text
    property alias cfg_colorStr: strField.text

    Kirigami.FormLayout {
        anchors.left: parent.left
        anchors.right: parent.right

        ComboBox {
            id: langCombo
            Kirigami.FormData.label: "Programmiersprache:"
            model: [
                { text: "JavaScript", value: "javascript" },
                { text: "Python", value: "python" },
                { text: "C#", value: "csharp" },
                { text: "C++", value: "cpp" }
            ]
            textRole: "text"
            valueRole: "value"
            
            // Lade den von Plasma gesetzten Wert
            Component.onCompleted: {
                var lang = page.cfg_language;
                for (var i = 0; i < model.length; ++i) {
                    if (model[i].value === lang) {
                        currentIndex = i;
                        break;
                    }
                }
            }

            // Sync. UI Änderung mit Plasma-Speicher (und aktiviere Anwenden-Button)
            onActivated: {
                page.cfg_language = currentValue;
            }
        }

        Item { Kirigami.FormData.isSection: true } // Abstand

        TextField { id: declField; Kirigami.FormData.label: "Farbe Keyword (z.B. const):" }
        TextField { id: varField; Kirigami.FormData.label: "Farbe Variablenname:" }
        TextField { id: puncField; Kirigami.FormData.label: "Farbe Satzzeichen (=, :, ,):" }
        TextField { id: brackField; Kirigami.FormData.label: "Farbe Klammern ({, }):" }
        TextField { id: propField; Kirigami.FormData.label: "Farbe Eigenschaften (day, month):" }
        TextField { id: numField; Kirigami.FormData.label: "Farbe Zahlen:" }
        TextField { id: strField; Kirigami.FormData.label: "Farbe Strings/Text:" }
    }
}
