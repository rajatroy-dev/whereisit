import CustomSafeAreaView from "@/components/ui/CustomSafeAreaView";
import IconSymbol from "@/components/ui/IconSymbol";
import { useAppTheme } from "@/state/app-store";
// https://docs.expo.dev/versions/latest/sdk/imagepicker/
import * as ImagePicker from 'expo-image-picker';
import { useMemo, useState } from "react";
import { FlatList, Image, KeyboardAvoidingView, Platform, ScrollView, StyleSheet, Text, TextInput, TouchableOpacity, View } from "react-native";
import Toast from 'react-native-toast-message';

export default function AddPage() {
    const theme = useAppTheme();
    const [permission, requestPermission] = ImagePicker.useCameraPermissions();


    const [itemName, setItemName] = useState('');
    const [isItemFocused, setItemFocused] = useState(false);
    const [locationName, setLocationName] = useState('');
    const [isLocationFocused, setLocationFocused] = useState(false);
    const [isLocationChoiceVisible, setLocationChoiceVisible] = useState(false);
    const [itemImages, setItemImages] = useState<IImageDate[]>([]);
    const [locationImages, setLocationImages] = useState<IImageDate[]>([]);

    const data = [
        { value: 1, label: 'Living Room > Closet' },
        { value: 2, label: 'Bedroom > Table' },
        { value: 3, label: 'Kitchen > Refrigerator' },
    ];

    const styles = useMemo(() => stylesheet(
        theme.color.val,
        theme.accentColor.val,
        theme.background.val,
        theme.borderColor.val,
        theme.borderColorFocus.val,
        theme.shadowColor.val,
        theme.borderColorHover.val
    ), [theme]);

    const pickImage = async (type: 'item' | 'location') => {
        // No permissions request is necessary for launching the image library
        let result = await ImagePicker.launchImageLibraryAsync({
            mediaTypes: ['images'],
            allowsMultipleSelection: true
        });

        console.log(result);

        if (!result.canceled) {
            const imagesCopy = type === 'item' ? [...itemImages] : [...locationImages];

            for (const eachImage of result.assets) {
                imagesCopy.push({
                    id: eachImage.assetId || `${Date.now() + Math.random()}`,
                    imagePath: eachImage.uri
                });
            }

            if (type === 'item') setItemImages(imagesCopy);
            if (type === 'location') setLocationImages(imagesCopy);
        }
    };

    const clickImage = async (type: 'item' | 'location') => {
        let permissionResponse;
        if (!permission?.granted) {
            permissionResponse = await requestPermission();
        }

        if (permissionResponse?.status === ImagePicker.PermissionStatus.DENIED) {
            Toast.show({
                type: 'error',
                text1: 'Need camera permission to take a photo',
                text2: 'Current staus: Denied'
            });
            return;
        }

        let result = await ImagePicker.launchCameraAsync({
            mediaTypes: ['images'],
            allowsMultipleSelection: true
        });

        console.log(result);

        if (!result.canceled) {
            const imagesCopy = type === 'item' ? [...itemImages] : [...locationImages];

            for (const eachImage of result.assets) {
                imagesCopy.push({
                    id: eachImage.assetId || `${Date.now() + Math.random()}`,
                    imagePath: eachImage.uri
                });
            }

            if (type === 'item') setItemImages(imagesCopy);
            if (type === 'location') setLocationImages(imagesCopy);
        }
    };

    return (
        <CustomSafeAreaView style={styles.screen}>
            <KeyboardAvoidingView
                behavior={Platform.OS === "ios" ? "padding" : "position"}
                style={styles.container}>
                {isLocationFocused
                    ? <>
                        {locationName.length > 0
                            ? <View style={{ justifyContent: 'flex-end' }}>
                                <View
                                    style={{
                                        width: '100%',
                                        justifyContent: 'center',
                                        alignItems: 'center'
                                    }}>
                                    {locationImages.length > 0
                                        ? <FlatList horizontal data={locationImages} renderItem={({ item, index }) => (
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
                                        : <IconSymbol name="image" color={theme.borderColorHover.val} size={200} />}
                                </View>
                                {isLocationChoiceVisible
                                    ? <View style={{
                                        width: '100%',
                                        position: 'absolute',
                                    }}>
                                        <ScrollView style={{
                                            bottom: 0,
                                            left: 0,
                                            elevation: 1,
                                            shadowColor: theme.colorPress.val,
                                            backgroundColor: theme.background.val,
                                            borderRadius: 5,
                                            marginHorizontal: 10,
                                            padding: 10
                                        }}>
                                            <TouchableOpacity
                                                onPress={() => { }}
                                                style={{ paddingBottom: 20 }}>
                                                <Text style={[styles.text, { textAlign: 'left' }]}>Abc</Text>
                                            </TouchableOpacity>
                                            <TouchableOpacity
                                                onPress={() => { }}
                                                style={{ paddingBottom: 20 }}>
                                                <Text style={[styles.text, { textAlign: 'left' }]}>Abc</Text>
                                            </TouchableOpacity>
                                            <TouchableOpacity
                                                onPress={() => { }}
                                                style={{ paddingBottom: 20 }}>
                                                <Text style={[styles.text, { textAlign: 'left' }]}>Abc</Text>
                                            </TouchableOpacity>
                                            <TouchableOpacity
                                                onPress={() => { }}
                                                style={{ paddingBottom: 20 }}>
                                                <Text style={[styles.text, { textAlign: 'left' }]}>Abc</Text>
                                            </TouchableOpacity>
                                        </ScrollView>
                                    </View>
                                    : <></>}
                            </View>
                            : <></>}
                        <View style={{ flexDirection: 'row' }}>
                            <TextInput
                                value={locationName}
                                onFocus={() => setItemFocused(true)}
                                onBlur={() => {
                                    setItemFocused(false);
                                    setLocationChoiceVisible(false);
                                }}
                                onChangeText={(text) => {
                                    setLocationName(text);
                                    setLocationChoiceVisible(true);
                                }}
                                placeholder="Where will it be stored? (Optional)"
                                placeholderTextColor={theme.placeholderColor.val}
                                style={[
                                    styles.textInput,
                                    isItemFocused ? styles.textInputFocus : styles.textInputBlur,
                                    { flex: 1, marginHorizontal: 8 }
                                ]} />
                        </View>
                        {locationName.length > 0
                            ? <View style={styles.addAnImageQuestion}>
                                <Text style={styles.text}>Want to add a location image?</Text>
                                <View style={styles.imageSelection}>
                                    <TouchableOpacity style={styles.cameraSelection} onPress={() => clickImage('location')}>
                                        <IconSymbol name="camera" color={theme.accentColor.val} size={32} />
                                    </TouchableOpacity>
                                    <TouchableOpacity style={styles.gallerySelection} onPress={() => pickImage('location')}>
                                        <IconSymbol name="image" color={theme.accentColor.val} size={32} />
                                    </TouchableOpacity>
                                </View>
                            </View>
                            : <></>}
                        <View style={styles.buttons}>
                            <TouchableOpacity style={styles.buttonCancel} onPress={() => {
                                setLocationFocused(false);
                                setLocationName('');
                                setLocationImages([]);
                            }}>
                                <Text style={styles.text}>Cancel</Text>
                            </TouchableOpacity>
                            <TouchableOpacity
                                disabled={!(locationName.length > 0)}
                                onPress={() => setLocationFocused(false)}
                                style={[
                                    styles.button,
                                    !(itemName.length > 0)
                                        ? { backgroundColor: theme.placeholderColor.val }
                                        : { backgroundColor: theme.accentColor.val }
                                ]}>
                                <Text style={styles.text}>Save</Text>
                            </TouchableOpacity>
                        </View>
                    </>
                    : <>
                        {itemName.length > 0
                            ? <View style={{
                                justifyContent: 'center',
                                alignItems: 'center',
                                backgroundColor: theme.background.val,
                                height: locationImages.length > 0 ? 540 : 350
                            }}>
                                {itemImages.length > 0
                                    ? <FlatList horizontal data={itemImages} renderItem={({ item, index }) => (
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
                                    : <IconSymbol name="image" color={theme.borderColorHover.val} size={200} />}
                                <View style={{
                                    width: '100%',
                                    borderWidth: 1,
                                    borderColor: theme.borderColor.val,
                                    borderRadius: 5,
                                    paddingHorizontal: 10,
                                    paddingVertical: 5
                                }}>
                                    <View style={{
                                        flexDirection: 'row',
                                        justifyContent: 'space-between',
                                        alignItems: 'center'
                                    }}>
                                        <View style={{ justifyContent: 'flex-start' }}>
                                            <Text style={{ fontSize: 10 }}>Storing</Text>
                                            <View>
                                                <Text style={{
                                                    color: theme.color.val,
                                                    fontWeight: 'bold',
                                                    fontSize: 20
                                                }}>
                                                    {itemName}
                                                </Text>
                                            </View>
                                        </View>
                                        <View>
                                            <View>
                                                <Text>Edit</Text>
                                            </View>
                                        </View>
                                    </View>
                                </View>
                                {locationImages.length > 0
                                    ? <FlatList horizontal data={locationImages} renderItem={({ item, index }) => (
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
                                    : <></>}
                                <View style={{ width: '100%', marginHorizontal: 50, marginVertical: 10, alignItems: 'center' }}>
                                    <TouchableOpacity
                                        onPress={() => setLocationFocused(true)}
                                        style={{
                                            borderWidth: 1,
                                            borderColor: theme.borderColorFocus.val,
                                            backgroundColor: theme.background.val,
                                            paddingVertical: 10,
                                            borderRadius: 5,
                                            width: '100%'
                                        }}>
                                        <Text style={styles.text}>{locationName.length > 0 ? locationName : 'Where will it be stored? (Optional)'}</Text>
                                    </TouchableOpacity>
                                </View>
                            </View>
                            : <></>}
                        {itemName.length > 0
                            ? <View style={{ flexDirection: 'row', width: '100%', marginBottom: 16 }}>
                                <TextInput
                                    value={locationName}
                                    onFocus={() => setItemFocused(true)}
                                    onBlur={() => setItemFocused(false)}
                                    onChangeText={setLocationName}
                                    placeholder="Where will it be stored? (Optional)"
                                    placeholderTextColor={theme.placeholderColor.val}
                                    style={[
                                        styles.textInput,
                                        isItemFocused ? styles.textInputFocus : styles.textInputBlur,
                                        { flex: 1, marginHorizontal: 8 }
                                    ]} />
                            </View>
                            : <></>}
                        {locationName.length > 0
                            ? <View style={[styles.addAnImageQuestion, { marginBottom: 16 }]}>
                                <Text style={styles.text}>Want to add a location image? (Optional)</Text>
                                <View style={styles.imageSelection}>
                                    <TouchableOpacity style={styles.cameraSelection} onPress={() => clickImage('item')}>
                                        <IconSymbol name="camera" color={theme.accentColor.val} size={32} />
                                    </TouchableOpacity>
                                    <TouchableOpacity style={styles.gallerySelection} onPress={() => pickImage('item')}>
                                        <IconSymbol name="image" color={theme.accentColor.val} size={32} />
                                    </TouchableOpacity>
                                </View>
                            </View>
                            : <></>}
                        <View style={{ flexDirection: 'row', width: '100%', marginBottom: 16 }}>
                            <TextInput
                                value={itemName}
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
                        {itemName.length > 0 && itemImages.length <= 0
                            ? <View style={[styles.addAnImageQuestion, { marginBottom: 16 }]}>
                                <Text style={styles.text}>Want to add an item image? (Optional)</Text>
                                <View style={styles.imageSelection}>
                                    <TouchableOpacity style={styles.cameraSelection} onPress={() => clickImage('item')}>
                                        <IconSymbol name="camera" color={theme.accentColor.val} size={32} />
                                    </TouchableOpacity>
                                    <TouchableOpacity style={styles.gallerySelection} onPress={() => pickImage('item')}>
                                        <IconSymbol name="image" color={theme.accentColor.val} size={32} />
                                    </TouchableOpacity>
                                </View>
                            </View>
                            : <></>}
                        {itemImages.length > 0
                            ? <View style={{
                                justifyContent: 'center',
                                alignItems: 'center',
                                backgroundColor: theme.background.val,
                                height: locationImages.length > 0 ? 540 : 350
                            }}>
                                <FlatList horizontal data={itemImages} renderItem={({ item, index }) => (
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
                            </View>
                            : <></>}
                        {itemName.length > 0
                            ? <View style={styles.buttons}>
                                <TouchableOpacity style={styles.buttonCancel}>
                                    <Text style={styles.text}>Cancel</Text>
                                </TouchableOpacity>
                                <TouchableOpacity
                                    disabled={!(itemName.length > 0)}
                                    style={[
                                        styles.button,
                                        !(itemName.length > 0)
                                            ? { backgroundColor: theme.placeholderColor.val }
                                            : { backgroundColor: theme.accentColor.val }
                                    ]}>
                                    <Text style={styles.text}>Save</Text>
                                </TouchableOpacity>
                            </View>
                            : <></>}
                    </>}
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
        marginBottom: 16
    }
});

type IImageDate = { id: string; imagePath: string; };