import CustomSafeAreaView from "@/components/ui/CustomSafeAreaView";
import IconSymbol from "@/components/ui/IconSymbol";
import useAppStore from "@/state/app-store";
// https://docs.expo.dev/versions/latest/sdk/imagepicker/
import * as ImagePicker from 'expo-image-picker';
import { useEffect, useMemo, useState } from "react";
import { FlatList, Image, KeyboardAvoidingView, Platform, StyleSheet, Text, TextInput, TouchableOpacity, View } from "react-native";
import Toast from 'react-native-toast-message';

export default function AddPage() {
    const theme = useAppStore(state => state.theme);
    const [permission, requestPermission] = ImagePicker.useCameraPermissions();


    const [itemName, setItemName] = useState('');
    const [isItemFocused, setItemFocused] = useState(false);
    const [images, setImages] = useState<{ id: string; imagePath: string; }[]>([]);

    useEffect(() => {
        const data = [
            // {
            //     id: '1',
            //     imagePath: 'https://picsum.photos/200'
            // },
            // {
            //     id: '2',
            //     imagePath: 'https://picsum.photos/200'
            // },
            // {
            //     id: '3',
            //     imagePath: 'https://picsum.photos/200'
            // }
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

    const pickImage = async () => {
        // No permissions request is necessary for launching the image library
        let result = await ImagePicker.launchImageLibraryAsync({
            mediaTypes: ['images'],
            allowsMultipleSelection: true
        });

        console.log(result);

        if (!result.canceled) {
            const imagesCopy = [...images];

            for (const eachImage of result.assets) {
                imagesCopy.push({
                    id: eachImage.assetId || `${Date.now() + Math.random()}`,
                    imagePath: eachImage.uri
                });
            }

            setImages(imagesCopy);
        }
    };

    const clickImage = async () => {
        let permissionResponse;
        if (!permission?.granted) {
            permissionResponse = await requestPermission();
        }

        if (permissionResponse?.status === ImagePicker.PermissionStatus.DENIED) {
            Toast.show({
                type: 'error',
                text1: 'Camera Permission',
                text2: 'Denied'
            });
            return;
        }

        let result = await ImagePicker.launchCameraAsync({
            mediaTypes: ['images'],
            allowsMultipleSelection: true
        });

        console.log(result);

        if (!result.canceled) {
            const imagesCopy = [...images];

            for (const eachImage of result.assets) {
                imagesCopy.push({
                    id: eachImage.assetId || `${Date.now() + Math.random()}`,
                    imagePath: eachImage.uri
                });
            }

            setImages(imagesCopy);
        }
    };

    return (
        <CustomSafeAreaView style={styles.screen}>
            <KeyboardAvoidingView
                behavior={Platform.OS === "ios" ? "padding" : "height"}
                style={styles.container}>
                {itemName.length > 0
                    ? <View style={{
                        justifyContent: 'center',
                        alignItems: 'center',
                        backgroundColor: theme.background.val,
                        height: 350
                    }}>
                        {images.length > 0
                            ? <FlatList horizontal data={images} renderItem={({ item, index }) => (
                                <Image
                                    style={{
                                        borderRadius: 5,
                                        flex: 1,
                                        height: 200,
                                        width: 200,
                                        marginLeft: index === 0 ? 0 : 10
                                    }}
                                    source={{ uri: item.imagePath }} />
                            )} />
                            : <IconSymbol name="image" color={theme.accentColor.val} size={200} />}
                        <View style={{ width: 200, marginBottom: 30, borderTopWidth: 1, borderColor: theme.borderColor.val }}>
                            <Text style={{
                                color: theme.color.val,
                                marginTop: 10,
                                textAlign: 'center'
                            }}>
                                {itemName}
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
                    : <></>}
                <View style={{ flexDirection: 'row' }}>
                    <TextInput
                        onFocus={() => setItemFocused(true)}
                        onBlur={() => setItemFocused(false)}
                        onChangeText={setItemName}
                        placeholder="What do you want to store?"
                        placeholderTextColor={theme.placeholderColor.val}
                        style={[
                            styles.textInput,
                            isItemFocused ? styles.textInputFocus : styles.textInputBlur,
                            { flex: 1, marginHorizontal: 8 }
                        ]} />
                </View>
                {itemName.length > 0
                    ? <View style={styles.addAnImageQuestion}>
                        <Text style={styles.text}>Want to add an image?</Text>
                        <View style={styles.imageSelection}>
                            <TouchableOpacity style={styles.cameraSelection} onPress={clickImage}>
                                <IconSymbol name="camera" color={theme.accentColor.val} size={32} />
                            </TouchableOpacity>
                            <TouchableOpacity style={styles.gallerySelection} onPress={pickImage}>
                                <IconSymbol name="image" color={theme.accentColor.val} size={32} />
                            </TouchableOpacity>
                        </View>
                    </View>
                    : <></>}
                <View style={styles.buttons}>
                    <TouchableOpacity style={styles.buttonCancel}>
                        <Text style={styles.text}>Cancel</Text>
                    </TouchableOpacity>
                    <TouchableOpacity style={styles.button}>
                        <Text style={styles.text}>Save</Text>
                    </TouchableOpacity>
                </View>
            </KeyboardAvoidingView>
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
        color: color,
        borderWidth: 1,
        borderRadius: 5,
        paddingHorizontal: 15,
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