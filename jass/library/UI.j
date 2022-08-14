
globals
    constant integer FRAME_ID = - 29734415
    Frame GUI
endglobals
library FrameLibrary initializer init
    struct Frame
        static hashtable HT = InitHashtable()
        static integer num = 0
        integer id = 0
        boolean isShow = true
        boolean isEnable = true
        boolean hover = false
        method numadd takes nothing returns nothing
            set num = num + 1
        endmethod
        static method getFrame takes integer id returns Frame
            local Frame f = LoadInteger(HT, FRAME_ID, id)
            if f == 0 then
                set f = Frame.allocate()
                set f.id = id
                call SaveInteger(HT, FRAME_ID, f.id, f)
            endif
            return f
        endmethod
        static method new takes string name, Frame parent returns Frame
            local Frame f = Frame.allocate()
            set f.id = DzCreateFrame(name, parent.id, 0)
            call SaveInteger(HT, FRAME_ID, f.id, f)
            return f
        endmethod
        static method newImage0 takes Frame parent returns Frame
            local Frame f = Frame.allocate()
            call f.numadd()
            set f.id = DzCreateFrameByTagName("BACKDROP", "Frame_Image" + I2S(num), parent.id, "ImageTemplate", 0)
            call SaveInteger(HT, FRAME_ID, f.id, f)
            return f
        endmethod
        static method newImage1 takes Frame parent, string path, real w, real h returns Frame
            local Frame f = Frame.allocate()
            call f.numadd()
            set f.id = DzCreateFrameByTagName("BACKDROP", "Frame_Image" + I2S(num), parent.id, "ImageTemplate", 0)
            if path != null then
                call DzFrameSetTexture(f.id, path, 0)
            endif
            call DzFrameSetSize(f.id, w, h)
            call SaveInteger(HT, FRAME_ID, f.id, f)
            return f
        endmethod
        static method newSprite takes Frame parent, string path returns Frame
            local Frame f = Frame.allocate()
            call f.numadd()
            set f.id = DzCreateFrameByTagName("SPRITE", "Frame_Sprite" + I2S(num), parent.id, "sprite", 0)
            call DzFrameSetModel(f.id, path, 0, 0)
            call SaveInteger(HT, FRAME_ID, f.id, f)
            return f
        endmethod
        static method newTips takes Frame parent, string path, real w, real h returns Frame
            local Frame f = Frame.allocate()
            call f.numadd()
            set f.id = DzCreateFrameByTagName("BACKDROP", "Frame_Image" + I2S(num), parent.id, path, 0)
            call DzFrameSetSize(f.id, w, h)
            call SaveInteger(HT, FRAME_ID, f.id, f)
            return f
        endmethod
        static method newText0 takes Frame parent, string ff returns Frame
            local Frame f = Frame.allocate()
            call f.numadd()
            set f.id = DzCreateFrameByTagName("TEXT", "Frame_Text" + I2S(num), parent.id, ff, 0)
            call SaveInteger(HT, FRAME_ID, f.id, f)
            return f
        endmethod
        static method newText1 takes Frame parent, string str, string ff returns Frame
            local Frame f = Frame.allocate()
            call f.numadd()
            set f.id = DzCreateFrameByTagName("TEXT", "Frame_Text" + I2S(num), parent.id, ff, 0)
            call DzFrameSetText(f.id, str)
            call SaveInteger(HT, FRAME_ID, f.id, f)
            return f
        endmethod
        static method newTextButton takes Frame parent returns Frame
            local Frame f = Frame.allocate()
            call f.numadd()
            set f.id = DzCreateFrameByTagName("GLUETEXTBUTTON", "Frame_Button" + I2S(num), parent.id, "template", 0)
            call SaveInteger(HT, FRAME_ID, f.id, f)
            return f
        endmethod
        static method newButton0 takes Frame parent returns Frame
            local Frame f = Frame.allocate()
            call f.numadd()
            set f.id = DzCreateFrameByTagName("BUTTON", "Frame_Button" + I2S(num), parent.id, "ButtonTemplate", 0)
            call SaveInteger(HT, FRAME_ID, f.id, f)
            return f
        endmethod
        static method newButton1 takes Frame parent, real w, real h returns Frame
            local Frame f = Frame.allocate()
            call f.numadd()
            set f.id = DzCreateFrameByTagName("BUTTON", "Frame_Button" + I2S(num), parent.id, "ButtonTemplate", 0)
            call DzFrameSetSize(f.id, w, h)
            call SaveInteger(HT, FRAME_ID, f.id, f)
            return f
        endmethod
        static method newButtonEmpty0 takes Frame parent returns Frame
            local Frame f = Frame.allocate()
            call f.numadd()
            set f.id = DzCreateFrameByTagName("BUTTON", "Frame_ButtonEmpty" + I2S(num), parent.id, "ButtonTemplateEmpty", 0)
            call SaveInteger(HT, FRAME_ID, f.id, f)
            return f
        endmethod
        static method newButtonEmpty1 takes Frame parent, real w, real h returns Frame
            local Frame f = Frame.allocate()
            call f.numadd()
            set f.id = DzCreateFrameByTagName("BUTTON", "Frame_ButtonEmpty" + I2S(num), parent.id, "ButtonTemplateEmpty", 0)
            call DzFrameSetSize(f.id, w, h)
            call SaveInteger(HT, FRAME_ID, f.id, f)
            return f
        endmethod
        static method newCloseButton takes Frame parent returns Frame
            local Frame f = Frame.allocate()
            call f.numadd()
            set f.id = DzCreateFrameByTagName("BUTTON", "Frame_ButtonEmpty" + I2S(num), parent.id, "icon1", 0)
            call SaveInteger(HT, FRAME_ID, f.id, f)
            return f
        endmethod
        method setScale takes real r returns nothing
            call DzFrameSetScale(id, r)
        endmethod
        method setColor takes integer c returns nothing
            call DzFrameSetTextColor(id, c)
        endmethod
        method setSize takes real w, real h returns nothing
            call DzFrameSetSize(id, w, h)
        endmethod
        method setTexture takes string path returns nothing
            call DzFrameSetTexture(id, path, 0)
        endmethod
        method setText takes string str returns nothing
            call DzFrameSetText(id, str)
        endmethod
        method setPoint takes integer a, Frame tar, integer b, real x, real y returns nothing
            call DzFrameSetPoint(id, a, tar.id, b, x, y)
        endmethod
        method setColor255 takes integer r, integer g, integer b returns nothing
            call DzFrameSetTextColor(id, DzGetColor(255, r, g, b))
        endmethod
        method setAllPoints takes Frame tar returns nothing
            call DzFrameSetAllPoints(id, tar.id)
        endmethod
        method clearAllPoints takes nothing returns nothing
            call DzFrameClearAllPoints(id)
        endmethod
        method regEvent takes integer i, code func returns nothing
            call DzFrameSetScriptByCode(id, i, func, false)
        endmethod
        method regWheelEvent takes code func returns nothing
            call DzFrameSetScriptByCode(id, 6, func, false)
        endmethod
        method regClickEvent takes code func returns nothing
            call DzFrameSetScriptByCode(id, 1, func, false)
        endmethod
        method hide takes nothing returns nothing
            call DzFrameShow(id, false)
            set isShow = false
        endmethod
        method show takes nothing returns nothing
            call DzFrameShow(id, true)
            set isShow = true
        endmethod
        method toggle takes nothing returns nothing
            if isShow then
                call DzFrameShow(id, false)
                set isShow = false
            else
                call DzFrameShow(id, true)
                set isShow = true
            endif
        endmethod
        method toggerHover takes string path0, string path1 returns nothing
            if hover then
                set hover = false
                call DzFrameSetTexture(id, path0, 0)
            else
                set hover = true
                call DzFrameSetTexture(id, path1, 0)
            endif
        endmethod
        method enable takes nothing returns nothing
            call DzFrameSetEnable(id, true)
            set isEnable = true
        endmethod
        method disable takes nothing returns nothing
            call DzFrameSetEnable(id, false)
            set isEnable = false
        endmethod
        method setAlpha takes integer a returns nothing
            call DzFrameSetAlpha(id, a)
        endmethod
        method onDestroy takes nothing returns nothing
            if id != 0 then
                call DzDestroyFrame(id)
            endif
            set id = 0
        endmethod
    endstruct

    
    function onButtonPressed takes nothing returns nothing

    endfunction
    function toggleImage takes nothing returns nothing
        
    endfunction

    struct ImageButton
        Frame image
        Frame button

        static method create takes Frame imageWidget, real w, real h returns ImageButton
            local ImageButton ib = ImageButton.allocate()
            set ib.image = imageWidget

            set ib.button = Frame.newTextButton(ib.image)
            call ib.button.setAllPoints(ib.image)
            call ib.button.regEvent(FRAME_EVENT_PRESSED, function onButtonPressed)
            call ib.button.regEvent(FRAME_MOUSE_ENTER, function toggleImage)
            call ib.button.regEvent(FRAME_MOUSE_LEAVE, function toggleImage)
            return ib
        endmethod

    endstruct


    private function init takes nothing returns nothing
        // local integer f = DzFrameGetTooltip()
        // local real size = 0.75
        set GUI = Frame.getFrame(DzGetGameUI())

        //call openBoardButton.setText("任务")

        //call DzFrameClearAllPoints(f)
        //call DzFrameSetPoint(f, 7, DzGetGameUI(), 7, 0, .14)
    endfunction
endlibrary

