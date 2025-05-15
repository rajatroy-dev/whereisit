import CustomSafeAreaView from "@/components/ui/CustomSafeAreaView";
import useAppStore from "@/state/app-store";
import { Text } from "@tamagui/core";
import { useMemo, useState } from "react";
import { StyleSheet, TouchableOpacity, View } from "react-native";

export default function AddPage() {
    const setTheme = useAppStore(state => state.setTheme);
    const theme = useAppStore(state => state.theme);

    const [currentTheme, setCurrentTheme] = useState('dark');
    const [counter, setCounter] = useState(1);

    const styles = useMemo(() => stylesheet(
        theme.color.val,
        theme.accentColor.val,
        theme.background.val
    ), [theme]);

    const handleTheme = () => {
        if (currentTheme === 'dark') {
            setTheme('light');
            setCurrentTheme('light');
        } else {
            setTheme('dark');
            setCurrentTheme('dark');
        }
    }

    return (
        <CustomSafeAreaView style={styles.screen}>
            <View style={styles.container}>
                <Text style={styles.text}>Where Is It?</Text>
                <Text style={styles.text}>{counter}</Text>
                <TouchableOpacity
                    onPress={handleTheme}
                    style={styles.button}>
                    <Text style={styles.text}>Toggle Theme</Text>
                </TouchableOpacity>
                <TouchableOpacity
                    onPress={() => setCounter(counter + 1)}
                    style={styles.button}>
                    <Text style={styles.text}>Increase Counter</Text>
                </TouchableOpacity>
            </View>
        </CustomSafeAreaView>
    );
}

const stylesheet = (
    color?: string,
    accentColor?: string,
    backgroundColor?: string
) => {
    console.log('Styles rendered!');

    return StyleSheet.create({
        screen: {
            backgroundColor: backgroundColor
        },
        container: {
            flex: 1,
            justifyContent: 'center',
            alignItems: 'center'
        },
        button: {
            paddingVertical: 10,
            marginVertical: 10,
            backgroundColor: accentColor
        },
        text: {
            color: color
        }
    });
}