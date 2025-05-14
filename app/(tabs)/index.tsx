import CustomSafeAreaView from "@/components/ui/CustomSafeAreaView";
import useAppStore from "@/state/app-store";
import { Text } from "@tamagui/core";
import { useState } from "react";
import { StyleSheet, TouchableOpacity, View } from "react-native";

export default function HomeLayput() {
    const [theme, setCurrentTheme] = useState('dark');
    const setTheme = useAppStore((state) => state.setTheme);

    const handleTheme = () => {
        if (theme === 'dark') {
            setTheme('light');
            setCurrentTheme('light');
        } else {
            setTheme('dark');
            setCurrentTheme('dark');
        }
    }

    return (
        <CustomSafeAreaView>
            <View style={styles.container}>
                <Text>Where Is It?</Text>
                <TouchableOpacity
                    onPress={handleTheme}
                    style={styles.button}>
                    <Text>Toggle Theme</Text>
                </TouchableOpacity>
            </View>
        </CustomSafeAreaView>
    );
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center'
    },
    button: {
        paddingVertical: 10
    }
});