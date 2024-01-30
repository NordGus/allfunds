import {Dispatch, PropsWithChildren} from "react";
import {Preview} from "../components/Products/Preview.tsx";
import {CartAction, Product} from "../App.tsx";

type Props = {
    products: Product[]
    cartDispatch: Dispatch<CartAction>
    hide: boolean
}

function Products({ products, cartDispatch, hide }: PropsWithChildren<Props>) {
    if (products.length === 0) return (
        <div className="h-[100vh] flex-1 flex justify-center items-center">
            <span>Loading Products</span>
        </div>
    )

    return (
        <div className={hide ? "hidden" : "flex-1 flex flex-wrap lg:px-6 px-2 py-10 gap-4 lg:gap-6 justify-between h-[100vh] overflow-y-scroll"}>
            {
                products.map(
                    product => <Preview
                        key={product.id}
                        name={product.name}
                        price={`${product.price}€`}
                        stock={product.stock}
                        description={product.description}
                        imageUrl={product.imageUrl}
                        onAdd={() => cartDispatch({type: "add", product: product, amount: 1})}
                    />
                )
            }
        </div>
    )
}

export default Products