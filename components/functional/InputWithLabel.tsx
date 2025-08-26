import { useAppTheme } from '@/state/app-store';
import { useMemo } from 'react';
import {
    StyleSheet,
    Text,
    TextInput,
    View
} from 'react-native';

export default function InputWithLabel({
    value,
    onChange,
    placeholder,
    label,
    focused,
    setFocused
}: IInputWithLabelProps) {
    const theme = useAppTheme();

    const styles = useMemo(() => stylesheet(
        theme.color.val,
        theme.accentColor.val,
        theme.borderColor.val,
        theme.shadowColor.val
    ), [theme]);

    return (
        <View
            style={[
                {
                    marginBottom: 16,
                    borderWidth: 1,
                    borderRadius: 5,
                    borderColor: theme.borderColor.val,
                    marginHorizontal: 8,
                    flexDirection: 'row',
                    width: '100%',
                    paddingHorizontal: 8
                },
                focused ? styles.textInputFocus : styles.textInputBlur
            ]}
        >
            <View style={{ width: '100%' }}>
                {value?.length > 0 && (
                    <Text style={{ fontSize: 10, paddingHorizontal: 4, paddingTop: 8 }}>
                        {label}
                    </Text>
                )}
                <TextInput
                    value={value}
                    onFocus={() => setFocused(true)}
                    onBlur={() => setFocused(false)}
                    onChangeText={onChange}
                    placeholder={placeholder}
                    placeholderTextColor={theme.placeholderColor.val}
                    style={[styles.textInput, value ? { fontWeight: 'bold' } : {}]}
                />
            </View>
        </View>
    );
}

const stylesheet = (
    color?: string,
    accentColor?: string,
    borderColor?: string,
    shadowColor?: string
) => StyleSheet.create({
    textInput: {
        color: color,
        shadowColor: shadowColor,
    },
    textInputFocus: {
        borderColor: accentColor
    },
    textInputBlur: {
        borderColor: borderColor,
    }
});

type IInputWithLabelProps = {
    value: string;
    onChange: ((text: string) => void) | undefined;
    placeholder: string | undefined;
    label: string;
    focused: boolean;
    setFocused: (value: boolean) => void;
};