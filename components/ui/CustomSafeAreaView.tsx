import { PropsWithChildren } from "react";
import { Platform, SafeAreaView, StatusBar, StyleProp, StyleSheet, ViewStyle } from "react-native";

export default function CustomSafeAreaView(props: props) {
    const { children, style } = props;
    return (
        <SafeAreaView style={[styles.container, styles.androidSafeArea, style]}>
            {children}
        </SafeAreaView>
    );
}

const styles = StyleSheet.create({
    androidSafeArea: { // https://stackoverflow.com/questions/51289587/how-to-use-safeareaview-for-android-notch-devices
        paddingTop: Platform.OS === "android" ? StatusBar.currentHeight : 0
    },
    container: {
        flex: 1
    }
});

type props = PropsWithChildren & {
    style?: StyleProp<ViewStyle>
};