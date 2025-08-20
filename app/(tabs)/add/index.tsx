import CustomSafeAreaView from "@/components/ui/CustomSafeAreaView";
import IconSymbol from "@/components/ui/IconSymbol";
import { useAppTheme } from "@/state/app-store";
import { Image } from "expo-image";
// https://docs.expo.dev/versions/latest/sdk/imagepicker/
import * as ImagePicker from 'expo-image-picker';
import { useMemo, useState } from "react";
import {
    FlatList,
    KeyboardAvoidingView,
    Platform,
    StyleSheet,
    Text,
    TextInput,
    TouchableOpacity,
    useWindowDimensions,
    View
} from "react-native";
import Toast from 'react-native-toast-message';

export default function AddPage() {
    const theme = useAppTheme();
    const [permission, requestPermission] = ImagePicker.useCameraPermissions();
    const { width } = useWindowDimensions();


    const [itemName, setItemName] = useState('');
    const [isItemFocused, setItemFocused] = useState(false);
    const [locationName, setLocationName] = useState('');
    const [isLocationFocused, setLocationFocused] = useState(false);
    const [selectLocation, setSelectLocation] = useState(false);
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

    const handleCancel = () => {
        setItemName('');
        setItemFocused(false);
        setLocationName('');
        setLocationFocused(false);
        setSelectLocation(false);
        setItemImages([]);
        setLocationImages([]);
    }

    if (selectLocation) {
        return <LocationSearch
            locationName={locationName}
            setSelectLocation={setSelectLocation}
            setLocationName={setLocationName}
        />;
    }

    return (
        <CustomSafeAreaView style={styles.screen}>
            <KeyboardAvoidingView
                behavior={Platform.OS === "ios" ? "padding" : "position"}
                style={styles.container}>
                <View style={[
                    {
                        marginBottom: 16,
                        borderWidth: 1,
                        borderRadius: 5,
                        borderColor: theme.borderColor.val,
                        marginHorizontal: 8,
                        flexDirection: 'row',
                        width: '100%',
                        paddingHorizontal: 8,
                    },
                    isItemFocused ? styles.textInputFocus : styles.textInputBlur,
                ]}>
                    <View style={{ width: '100%' }}>
                        {itemName.length > 0
                            ? <Text style={{ fontSize: 10, paddingHorizontal: 4, paddingTop: 8 }}>Storing</Text>
                            : <></>}
                        <TextInput
                            value={itemName}
                            onFocus={() => setItemFocused(true)}
                            onBlur={() => setItemFocused(false)}
                            onChangeText={setItemName}
                            placeholder="What do you want to store?"
                            placeholderTextColor={theme.placeholderColor.val}
                            style={[
                                styles.textInput,
                                itemName.length > 0 ? { fontWeight: 'bold' } : { fontWeight: 'normal' },
                            ]} />
                    </View>
                </View>
                {itemName.length > 0 && itemImages.length > 0
                    ? <View style={{
                        justifyContent: 'center',
                        alignItems: 'center',
                        backgroundColor: theme.background.val,
                        height: 216
                    }}>
                        <FlatList horizontal data={itemImages} renderItem={({ item, index }) => (
                            <Image
                                style={{
                                    borderRadius: 5,
                                    flex: 1,
                                    height: 200,
                                    width: 200,
                                    marginLeft: 10
                                }}
                                source={{ uri: item.imagePath }} />
                        )} />
                    </View>
                    : <></>}
                {itemName.length > 0
                    ? <View style={[styles.addAnImageQuestion, { marginBottom: 16 }]}>
                        {itemImages.length <= 0
                            ? <Text style={styles.text}>Want to add an item image? (Optional)</Text>
                            : <Text style={styles.text}>Add more location images? (Optional)</Text>}
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
                {itemName.length > 0
                    ? <TouchableOpacity
                        onPress={() => setSelectLocation(true)}
                        style={[
                            {
                                marginBottom: 16,
                                borderWidth: 1,
                                borderRadius: 5,
                                borderColor: theme.borderColor.val,
                                marginHorizontal: 8,
                                flexDirection: 'row',
                                width: '100%',
                                paddingHorizontal: 8,
                            },
                            isLocationFocused ? styles.textInputFocus : styles.textInputBlur,
                        ]}>
                        <View style={{ paddingHorizontal: 4, width: '100%', paddingBottom: 10 }}>
                            {locationName.length > 0
                                ? <Text style={{ fontSize: 10, paddingVertical: 10 }}>At</Text>
                                : <></>}
                            <Text
                                style={[
                                    styles.textInput,
                                    locationName.length > 0 ? { fontWeight: 'bold' } : { fontWeight: 'normal', color: theme.placeholderColor.val },
                                ]}>
                                {locationName.length > 0 ? locationName : 'Where will you keep this item? (Optional)'}
                            </Text>
                        </View>
                    </TouchableOpacity>
                    : <></>}
                {locationName.length > 0 && locationImages.length <= 0
                    ? <View style={[styles.addAnImageQuestion, { marginBottom: 16 }]}>
                        <Text style={styles.text}>Want to add a location image? (Optional)</Text>
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
                {locationName.length > 0 && locationImages.length > 0
                    ? <View style={{
                        justifyContent: 'center',
                        alignItems: 'center',
                        backgroundColor: theme.background.val,
                        height: 216
                    }}>
                        <FlatList horizontal data={locationImages} renderItem={({ item, index }) => {
                            if (index === itemImages.length - 1) {
                                return <TouchableOpacity
                                    onPress={() => pickImage('location')}
                                    style={{
                                        borderRadius: 5,
                                        marginHorizontal: 10,
                                        backgroundColor: '#BEBEBE',
                                        height: 200,
                                        width: 100,
                                        justifyContent: 'center',
                                        alignItems: 'center'
                                    }}>
                                    <Image
                                        style={{
                                            height: 50,
                                            width: 50
                                        }}
                                        source={require('@/assets/images/plus.png')} />
                                </TouchableOpacity>;
                            }
                            return <Image
                                style={{
                                    borderRadius: 5,
                                    flex: 1,
                                    height: 200,
                                    width: 200,
                                    marginLeft: 10
                                }}
                                source={{ uri: item.imagePath }} />;
                        }} />
                    </View>
                    : <></>}
                {itemName.length > 0
                    ? <View style={styles.buttons}>
                        <TouchableOpacity
                            onPress={handleCancel}
                            style={styles.buttonCancel}
                        >
                            <Text style={styles.text}>CANCEL</Text>
                        </TouchableOpacity>
                        <TouchableOpacity
                            disabled={!(itemName.length > 0)}
                            style={[
                                styles.button,
                                { backgroundColor: theme.accentColor.val }
                            ]}>
                            <Text style={styles.text}>SAVE</Text>
                        </TouchableOpacity>
                    </View>
                    : <></>}
            </KeyboardAvoidingView>
        </CustomSafeAreaView>
    );
}

function LocationSearch(
    props: {
        locationName: string;
        setLocationName: (value: string) => void;
        setSelectLocation: (value: boolean) => void;
    }
) {
    const theme = useAppTheme();
    const { locationName, setLocationName, setSelectLocation } = props;

    const styles = useMemo(() => stylesheet(
        theme.color.val,
        theme.accentColor.val,
        theme.background.val,
        theme.borderColor.val,
        theme.borderColorFocus.val,
        theme.shadowColor.val,
        theme.borderColorHover.val
    ), [theme]);

    const handleCancel = () => {
        setSelectLocation(false);
    }

    return (
        <CustomSafeAreaView style={styles.screen}>
            <KeyboardAvoidingView
                behavior={Platform.OS === "ios" ? "padding" : "position"}
                style={styles.container}>
                <View style={[
                    {
                        marginBottom: 16,
                        borderWidth: 1,
                        borderRadius: 5,
                        marginHorizontal: 8,
                        flexDirection: 'row',
                        width: '100%',
                        paddingHorizontal: 8,
                        borderColor: theme.accentColor.val
                    }
                ]}>
                    <View style={{ width: '100%' }}>
                        <TextInput
                            value={locationName}
                            autoFocus
                            onChangeText={setLocationName}
                            placeholder='Where will you keep this item? (Optional)'
                            placeholderTextColor={theme.placeholderColor.val} />
                    </View>
                </View>
                <View style={styles.buttons}>
                    <TouchableOpacity
                        style={styles.buttonCancel}
                        onPress={handleCancel}>
                        <Text style={styles.text}>CANCEL</Text>
                    </TouchableOpacity>
                    <TouchableOpacity
                        disabled={locationName.length <= 0}
                        onPress={handleCancel}
                        style={[
                            styles.button,
                            locationName.length <= 0
                                ? { backgroundColor: theme.backgroundPress.val }
                                : { backgroundColor: theme.accentColor.val }
                        ]}>
                        <Text style={styles.text}>SAVE</Text>
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
        shadowColor: shadowColor,
    },
    textInputFocus: {
        borderColor: accentColor
    },
    textInputBlur: {
        borderColor: borderColor,
    },
    addAnImageQuestion: {
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
        marginBottom: 16
    }
});

type IImageDate = { id: string; imagePath: string; };