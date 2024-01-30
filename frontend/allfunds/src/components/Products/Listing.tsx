import {PropsWithChildren} from "react";

type Props = {
    name: string,
    price: string,
    imageUrl: string
}

export function Listing({ name, price, imageUrl, children }: PropsWithChildren<Props>) {
    return (
        <div className="grid grid-cols-3 grid-rows-1 gap-2">
            <div className="h-[5vh] flex justify-center items-center overflow-clip">
                <img className="h-full" src={ imageUrl } alt={ name }/>
            </div>
            <div className="flex flex-col gap-2">
                <h4>{name}</h4>
                <div className="flex justify-between items-center">
                    {children}
                </div>
            </div>
            <div className="flex justify-center items-center">
                <p>{price}</p>
            </div>
        </div>
    )
}