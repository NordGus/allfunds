import {PropsWithChildren} from "react";

type Props = {
    name: string,
    price: string,
    description: string,
    imageUrl: string
}

export function Preview({ name, price, description, imageUrl, children }: PropsWithChildren<Props>) {
    return (
        <div className="grid grid-cols-2 grid-rows-4 gap-2 w-[15vw]">
            <div className="col-span-2 flex justify-center items-center overflow-clip">
                <img className="w-full" src={ imageUrl } alt={ name }/>
            </div>
            <h4>{name}</h4><p>{price}</p>
            <p className="col-span-2">{description}</p>
            <div className="col-span-2 flex justify-between">
                { children }
            </div>
        </div>
    )
}