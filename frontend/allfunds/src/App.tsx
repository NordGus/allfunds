import {useEffect, useReducer, useState} from "react";
import Products from "./panels/Products.tsx";
import Cart from "./panels/Cart.tsx";

function App() {
    const inDesktop = window.innerWidth > 1024
    const [cart, cartDispatch] = useReducer(cartReducer, initialCart)
    const [products, setProducts] = useState(new Array<Product>())
    const [hideCart, setHideCart] = useState(!inDesktop)

    useEffect(() => {
        fetch("http://localhost:3000/grocery",
            { headers: { "Content-Type": "application/json" } }
        ).then(response => {
            if (response.ok) return response.json()
        }).then((products: ProductResponse[]) => {
            setProducts(products.map(product => {
                return {
                    id: product.id,
                    imageUrl: product.image_url,
                    stock: product.stock,
                    name: product.productName,
                    description: product.productDescription,
                    price: product.price,
                    favorite: product.favorite,
                }
            }))
        })
        .catch(err => console.error(err))
    }, []);

    return (
        <div className="flex relative">
            <Products products={products} cartDispatch={cartDispatch} hide={inDesktop ? false : !hideCart}/>
            <Cart items={cart} dispatch={cartDispatch} hide={hideCart} onHide={setHideCart} />
            <div className="flex justify-between gap-2 absolute bottom-0 right-0 left-0 p-2">
                <a
                >
                    Favorites
                </a>
                <a
                    className="cursor-pointer text-xl py-1 px-2 bg-neutral-300 hover:bg-neutral-500"
                    onClick={() => setHideCart(false)}
                >
                    Cart
                </a>
            </div>
        </div>
    )
}

export default App;

type ProductResponse = {
    id: string,
    image_url: string,
    stock: number,
    productName: string,
    price: number,
    productDescription: string,
    favorite: number
}

export type Product = {
    id: string,
    imageUrl: string,
    stock: number,
    name: string,
    description: string,
    price: number,
    favorite: number,
}

export type Item = {
    product: Product,
    amount: number
}

type CartState = Item[]

export type CartAction = {
    type: string
    product: Product
    amount: number
}

function cartReducer(cart: CartState, action: CartAction): CartState {
    switch (action.type) {
        case "add": {
            if (cart.find(item => item.product.id === action.product.id)) return cart

            return [...cart, { product: action.product, amount: action.amount }]
        }
        case "update": {
            return cart.map(item => {
                if (item.product.id === action.product.id) return { product: action.product, amount: action.amount }
                return item
            })
        }
        case "delete": {
            return cart.filter(item => item.product.id !== action.product.id)
        }
        default: {
            throw Error("Unknown action: " + action.type)
        }
    }
}

const initialCart: CartState = []