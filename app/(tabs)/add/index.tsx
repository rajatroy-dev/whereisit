import CustomSafeAreaView from "@/components/ui/CustomSafeAreaView";
import IconSymbol from "@/components/ui/IconSymbol";
import useAppStore from "@/state/app-store";
import { useEffect, useMemo, useState } from "react";
import { FlatList, Image, StyleSheet, Text, TextInput, TouchableOpacity, View } from "react-native";

export default function AddPage() {
    const theme = useAppStore(state => state.theme);

    const [isItemFocused, setItemFocused] = useState(false);
    const [images, setImages] = useState<{ id: number; imagePath: string; }[]>([]);

    useEffect(() => {
        const data = [
            {
                id: 1,
                imagePath: 'https://picsum.photos/200'
            },
            {
                id: 2,
                imagePath: 'https://picsum.photos/200'
            },
            {
                id: 3,
                imagePath: 'https://picsum.photos/200'
            }
        ];
        setImages(data);
    }, []);

    const styles = useMemo(() => stylesheet(
        theme.color.val,
        theme.accentColor.val,
        theme.background.val,
        theme.borderColor.val,
        theme.borderColorFocus.val,
        theme.shadowColor.val,
        theme.borderColorHover.val
    ), [theme]);

    return (
        <CustomSafeAreaView style={styles.screen}>
            <View style={styles.container}>
                <View style={{
                    justifyContent: 'center',
                    alignItems: 'center',
                    backgroundColor: theme.background.val,
                    height: 300
                }}>
                    <FlatList horizontal data={images} renderItem={({ item }) => (
                        <Image style={{ flex: 1, height: 200, width: 200, marginLeft: 10 }} source={{ uri: item.imagePath }} />
                    )} />
                    <View style={{ elevation: 2, backgroundColor: theme.background.val, marginBottom: 30 }}>
                        <Text style={{
                            color: theme.color.val,
                            marginTop: 10,
                            textAlign: 'center'
                        }}>
                            Image
                        </Text>
                        <TextInput
                            placeholder="Where are you storing it?"
                            placeholderTextColor={theme.placeholderColor.val}
                            style={[
                                styles.textInput,
                                isItemFocused ? styles.textInputFocus : styles.textInputBlur
                            ]} />
                    </View>
                </View>
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
                <View style={styles.buttons}>
                    <TouchableOpacity style={styles.buttonCancel}>
                        <Text style={styles.text}>Cancel</Text>
                    </TouchableOpacity>
                    <TouchableOpacity style={styles.button}>
                        <Text style={styles.text}>Save</Text>
                    </TouchableOpacity>
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
    shadowColor?: string,
    cancelBackground?: string
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
        marginHorizontal: 10,
        backgroundColor: accentColor,
        borderRadius: 5,
        flex: 1
    },
    buttonCancel: {
        paddingVertical: 10,
        marginHorizontal: 10,
        backgroundColor: cancelBackground,
        borderRadius: 5,
        flex: 1
    },
    text: {
        color: color,
        paddingHorizontal: 10,
        textAlign: 'center'
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
        marginBottom: 10,
        alignItems: 'center'
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
    },
    buttons: {
        flexDirection: 'row',
        justifyContent: 'space-between',
        width: '100%',
        marginBottom: 10
    }
});