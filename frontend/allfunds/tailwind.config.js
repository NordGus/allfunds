/** @type {import('tailwindcss').Config} */
export default {
  content: [
      "./index.html",
      "./src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {
        gridTemplateColumns: {
            "product-preview": "1fr min-content",
            "item": "min-content 1fr min-content"
        },
        gridTemplateRows: {
            "product-preview": "8vw min-content 1fr min-content"
        }
    },
  },
  plugins: [],
}

