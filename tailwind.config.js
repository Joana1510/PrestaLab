import forms from '@tailwindcss/forms';
import defaultTheme from 'tailwindcss/defaultTheme';

/** @type {import('tailwindcss').Config} */
export default {
    content: [
        './vendor/laravel/framework/src/Illuminate/Pagination/resources/views/*.blade.php',
        './storage/framework/views/*.php',
        './resources/views/**/*.blade.php',
        './resources/js/**/*.js',
    ],

    theme: {
        extend: {
            fontFamily: {
                sans: [...defaultTheme.fontFamily.sans],
            },
            colors: {
                // Azul marino: identidad, menús y encabezados
                navy: {
                    50: '#f0f4fa',
                    100: '#dce5f3',
                    200: '#bccce8',
                    300: '#90abd6',
                    400: '#6385c0',
                    500: '#4466a8',
                    600: '#34518a',
                    700: '#2b4170',
                    800: '#243558',
                    900: '#1b2a47',
                    950: '#0f1a2f',
                },
                // Verde: acciones principales y estado "Disponible"
                brand: {
                    50: '#ecfdf3',
                    100: '#d1fae0',
                    200: '#a6f4c5',
                    300: '#6ce9a6',
                    400: '#32d583',
                    500: '#12b76a',
                    600: '#039855',
                    700: '#027a48',
                    800: '#05603a',
                    900: '#054f31',
                    950: '#053321',
                },
            },
        },
    },

    plugins: [forms],
};