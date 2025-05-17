import CustomSafeAreaView from "@/components/ui/CustomSafeAreaView";
import IconSymbol from "@/components/ui/IconSymbol";
import useAppStore from "@/state/app-store";
import { useMemo, useState } from "react";
import { StyleSheet, Text, TextInput, TouchableOpacity, View } from "react-native";

export default function AddPage() {
    const theme = useAppStore(state => state.theme);

    const [isItemFocused, setItemFocused] = useState(false);

    const styles = useMemo(() => stylesheet(
        theme.color.val,
        theme.accentColor.val,
        theme.background.val,
        theme.borderColor.val,
        theme.borderColorFocus.val,
        theme.shadowColor.val
    ), [theme]);

    return (
        <CustomSafeAreaView style={styles.screen}>
            <View style={styles.container}>
                <TextInput
                    onFocus={() => setItemFocused(true)}
                    onBlur={() => setItemFocused(false)}
                    placeholder="What do you want to store?"
                    placeholderTextColor={theme.placeholderColor.val}
                    style={[
                        styles.textInput,
                        isItemFocused ? styles.textInputFocus : styles.textInputBlur
                    ]} />
                <View style={styles.addAnImageQuestion}>
                    <Text style={styles.text}>Want to add an image?</Text>
                    <View style={styles.imageSelection}>
                        <TouchableOpacity style={styles.cameraSelection}>
                            <IconSymbol name="camera" color={theme.accentColor.val} />
                        </TouchableOpacity>
                        <TouchableOpacity style={styles.gallerySelection}>
                            <IconSymbol name="image" color={theme.accentColor.val} />
                        </TouchableOpacity>
                    </View>
                </View>
            </View>
        </CustomSafeAreaView>
    );
}

const stylesheet = (
    color?: string,
    accentColor?: string,
    backgroundColor?: string,
    borderColor?: string,
    borderColorFocus?: string,
    shadowColor?: string
) => StyleSheet.create({
    screen: {
        backgroundColor: backgroundColor
    },
    container: {
        flex: 1,
        marginHorizontal: 10,
        justifyContent: 'flex-end',
        alignItems: 'center'
    },
    button: {
        paddingVertical: 10,
        marginVertical: 10,
        backgroundColor: accentColor
    },
    text: {
        color: color,
        paddingLeft: 10
    },
    textInput: {
        borderWidth: 1,
        borderRadius: 5,
        paddingHorizontal: 10,
        width: '100%',
        shadowColor: shadowColor,
        borderColor: borderColor,
        marginVertical: 10
    },
    textInputFocus: {
        borderWidth: 2,
        borderColor: borderColorFocus
    },
    textInputBlur: {
        borderWidth: 1,
        borderColor: borderColor,
    },
    addAnImageQuestion: {
        width: '100%',
        flexDirection: 'row',
        justifyContent: 'space-between',
        marginBottom: 10
    },
    imageSelection: {
        flexDirection: 'row'
    },
    cameraSelection: {
        paddingRight: 10
    },
    gallerySelection: {
        paddingLeft: 10,
        paddingRight: 5
    }
});